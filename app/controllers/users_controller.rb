class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.first_name} #{@user.last_name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def sign_in

  end

  def authenticate
    @user = User.find_by_email(params[:email])
    if @user
      if @user.authenticate(params[:password])
        flash[:success] = "Welcome back #{@user.first_name} #{@user.last_name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        # deny_user
        flash.now[:error] = 'Incorrect password, please check again'
        render 'users/sign_in'
      end
    else
      # deny_user
      flash.now[:error] = 'User is not found, create new one and enjoy'
      @user = User.new
      render 'users/new'
    end
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
    format.json { render :json => !@user }
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :identification_number, :email, :password)
  end

  def log_out
    session[:user_id] = nil
    redirect_to root_path, flash: { success: 'Logged Out' }
  end
end
