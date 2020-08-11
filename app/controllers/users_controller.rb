class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_problems = @user.problems
  end
end
