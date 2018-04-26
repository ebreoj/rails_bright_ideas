class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:create]

  # def new
  # end

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to "/ideas"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to '/'
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end

  private
    def login_params
      params.require(:login).permit(:email, :password)
    end
end

