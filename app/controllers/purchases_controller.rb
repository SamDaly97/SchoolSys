class PurchasesController < ApplicationController
skip_before_action :verify_authenticity_token

  def index
  end

  def create_purchase
    # PAYPAL CREATE ORDER
    price = '100.00'
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => price
          }
        }
      ]
    })
    begin
      response = @client.execute request
      purchase = Purchase.new
      purchase.price = price.to_i
      purchase.token = response.result.id
      if purchase.save
        return render :json => {:token => response.result.id}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def capture_purchase
    # PAYPAL CAPTURE ORDER
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
begin
  response = @client.execute request
  order = Order.find_by :token => params[:order_id]
  order.paid = response.result.status == 'COMPLETED'
  if order.save
    return render :json => {:status => response.result.status}, :status => :ok
  end
rescue PayPalHttp::HttpError => ioe
  # HANDLE THE ERROR
end
  end

  private
  def paypal_init
    client_id = 'AeZJsC8aFIsxie70hdt9WVRHTmwRby3pWf8im6O9zZ-56Ldn2_Ztib0z7kMESnO2C_aYV0q7uxGbnhq7'
    client_secret = 'EH064U8CDRyZ3o0eB0Jb267VMy_VTTdSK06D1-j1a2oaYkeJRR4NAyG44mEDkFP9feWv93x-ETwaTy8J'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
