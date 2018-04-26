class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    if session[:user_id]
      redirect_to '/ideas'
    end
  end

  def create
    user = User.new(register_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/ideas'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @this_user = current_user
    # render :edit
  end

  def update
    user = current_user
    if not user.update(edit_params)
      flash[:errors] = user.errors.full_messages
    end
    redirect_to "/ideas"
  end


  private
    def register_params
      params.require(:register).permit(:name, :alias, :email, :password, :password_confirmation)
    end

    def edit_params
      params.require(:edit).permit(:name, :alias, :email)
    end
end
