class UsersController < ApplicationController
  before_action :authenticate_user!

  def add_onesignal_id
    @user = current_user
    respond_to do |format|
      if @user.update(onesignal_id: params['onesignal_id'])
        format.json { render json: @user.to_json( only: [:name, :email, :id] ), status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_account
    @user = current_user
  end

  def update_account
    @user = current_user
    respond_to do |format|
      password_valid = user_params[:password].present? && !user_params[:password].blank?
      password_valid = password_valid && user_params[:password_confirmation].present? && !user_params[:password_confirmation].blank?
      password_valid = password_valid && user_params[:password] == user_params[:password_confirmation]

      if password_valid && @user.update(user_params)
        format.html { redirect_to new_user_session_url, notice: "Información y contraseña actualizada correctamente." }
        format.json { render :show, status: :ok, location: @user }
      else
        if !password_valid
          format.html { redirect_to my_account_url, alert: "La confirmación de contraseña no coincide." }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        elsif @user.update_attribute('email', user_params[:email]) && @user.update_attribute('name', user_params[:name])
          format.html { redirect_to my_account_url, notice: "Información actualizada correctamente." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :my_account, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
   def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
