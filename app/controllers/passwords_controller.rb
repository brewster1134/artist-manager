class PasswordsController < ApplicationController
  skip_before_filter :check_for_user
  include General

  def new
  end

  def create
    user = User.find_by_email(params[:password][:email])
    if user
      user.password_reset_token = generate_token
      user.save(validate: false)
      UserMailer.password_reset(user).deliver
      redirect_to login_path, :notice => "An email was sent with a link to reset your password."
    else
      flash[:alert] = "That email was not found"
      render :new
    end
  end

  def edit
    @user = current_user || User.find_by_password_reset_token(params[:token])
    if !@user
      if params[:token]
        redirect_to change_password_request_path, :alert => "Invalid token.  Please make a new request to change your password."
      else
        redirect_to login_path, :alert => "Please login to change your email"
      end
    end
  end

  def update
    @user = current_user || User.find_by_password_reset_token(params[:user][:password_reset_token])
    if @user.try(:update_attributes, params[:user])
      session[:user_id] = @user.id
      @user.password_reset_token = nil
      @user.save!
      redirect_to home_path, :notice => "Password is changed and you are now logged in."
    else
      render :edit
    end
  end

end
