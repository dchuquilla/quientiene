class Users::OmniauthController < ApplicationController

  # facebook callback
  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      UserMailer.signup_email(@user).deliver_later
      sign_in @user
      redirect_to dashboard_path
      flash[:notice] = 'Acceso exitoso mediante Facebook' if is_navigational_format?
    else
      flash[:alert] = 'Hubo un problema para registrarse mediante Facebook. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  # google callback
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      UserMailer.signup_email(@user).deliver_later
      sign_in @user
      redirect_to dashboard_path
      flash[:notice] = 'Acceso exitoso mediante Google' if is_navigational_format?
    else
      flash[:alert] = 'Hubo un problema para registrarse mediante Google. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  # twitter callback
  def twitter
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      UserMailer.signup_email(@user).deliver_later
      sign_in @user
      redirect_to dashboard_path
      flash[:notice] = 'Acceso exitoso mediante Twitter' if is_navigational_format?
    else
      flash[:alert] = 'Hubo un problema para registrarse mediante Twitter. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:alert] = 'Hubo un problema para iniciar sesión. Por favor regístrese o inténtelo más tarde.'
    redirect_to new_user_registration_url
  end
end
