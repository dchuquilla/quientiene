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
      if params[:user].present?
        user_params = params.require(:user).permit(:email, :password, :password_confirmation)
        user = User.new(user_params)
      end

      can_destroy_user = false
      if user.valid?
        user.save
        can_destroy_user = true
      
        @vehicle.user_id = user.id
        @replacement_request.user_id = user.id
        
        can_destroy_vehicle = false
        if @vehicle.valid?
          @vehicle.save!
          can_destroy_vehicle = true

          @replacement_request.vehicle = @vehicle
        end
        
        respond_to do |format|
          if @replacement_request.valid?
            @replacement_request.state = "created"
            @replacement_request.save!
            resource = user

            PushNotificationsHelper::new_request_created(@replacement_request, new_replacement_proposal_path(replacement_request_id: @replacement_request.id))
            
            sign_up(resource_name, resource)
            
            format.html { redirect_to dashboard_path, notice: "Solicitud creada correctamente, notificamos a las empresas, ahora están preparando sus propuestas." }
            format.json { render json: @replacement_request.errors, status: :unprocessable_entity }
          else
            user.destroy if can_destroy_user
            @vehicle.destroy if can_destroy_vehicle
            build_resource
            
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @replacement_request.errors, status: :unprocessable_entity }
          end
        end
      else
        super
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

  private

    def create_step_by_step(resource)
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
      end
      resource
    end
end
