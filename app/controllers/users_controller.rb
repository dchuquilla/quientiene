class UsersController < ApplicationController
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
end
