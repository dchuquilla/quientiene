class Users::OmniauthController < ApplicationController

  # facebook callback
  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      flash[:error] = 'Hubo un problema para registrarse mediante Facebook. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  # google callback
  def google_oauth2
    @user = User.create_from_google_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = 'Hubo un problema para registrarse mediante Google. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  # twitter callback
  def twitter
    @user = User.create_from_twitter_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      flash[:error] = 'Hubo un problema para registrarse mediante Twitter. Por favor regístrese o inténtelo más tarde.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:error] = 'Hubo un problema para iniciar sesión. Por favor regístrese o inténtelo más tarde.'
    redirect_to new_user_registration_url
  end
end
