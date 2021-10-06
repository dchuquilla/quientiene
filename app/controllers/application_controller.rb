class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  before_action :set_metadata

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def set_metadata
    @title = "QuienTiene :: "
    case params[:controller]
    when 'users/sessions'
      @title += "Ingreso de usuarios"
    when 'users/registrations'
      @title += "Registro de usuarios"
    when 'devise/unlocks'
      @title += "Solicitar desbloqueo de cuenta"
    when 'devise/passwords'
      @title += "No recuerdo mi clave"
    else
      @title += "encuentre el repuesto que está buscando"
    end      
  end

  def states_provinces
    render json: CS.states(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state_province], params[:country]).to_json
  end
end
