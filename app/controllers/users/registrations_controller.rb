# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @vehicle = Vehicle.new
    @replacement_request = ReplacementRequest.new
    super
  end

  # POST /resource
  def create
    if params[:empresa].present? && params[:empresa] = 'si'
      super
      resource.remove_role :customer
      resource.add_role :shop
    elsif params[:new_request].present?
      if params[:vehicle].present?
        vehicle_params = params.require(:vehicle).permit(:user_id, :plate, :chasis, :brand, :model, :year)
        @vehicle = Vehicle.new(vehicle_params)
      end
      if params[:replacement_request].present?
        replacement_request_params = params.require(:replacement_request).permit(:user_id, :vehicle_id, :part_number, :short_name, :description, :country, :state_province, :city, photos: [])
        @replacement_request = ReplacementRequest.new(replacement_request_params)
      end
      if @vehicle.nil? 
        
      end
      if @vehicle.valid? && @replacement_request.valid?
        super
        @vehicle.user_id = resource.id
        @replacement_request.state = "created"
        @replacement_request.user_id = resource.id
        @vehicle.save
        @replacement_request.save
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @replacement_request.errors, status: :unprocessable_entity }
        end
      end
    else
      super
    end

  end

  # GET /resource/edit
  def edit
    redirect_to my_account_url
    #super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
