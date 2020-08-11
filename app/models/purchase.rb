class Purchase < ApplicationRecord
  createOrder: async () => {
  const response = await fetch('/create_order', {method: 'POST'});
  const responseData = await response.json();
  return responseData.token;
}

onApprove: async (data) => {
  const response = await fetch('/capture_order', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({order_id: data.orderID})
  });
  const responseData = await response.json();
  if (responseData.status === 'COMPLETED') {
    alert('COMPLETED');
    // REDIRECT TO SUCCESS PAGE
  }
}
end
