# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  add_flash_types :info, :error, :warning
  before_action :set_metadata

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    dashboard_path
    stored_location_for(resource) || dashboard_path
  end

  def set_metadata
    Rails.logger.info 'PARAMS ***********************'
    Rails.logger.info params.inspect

    @title = ''
    case params[:controller]
    when 'users/sessions'
      @title += 'Ingreso de usuarios'
    when 'users/registrations'
      @title += if params[:action] == 'new'
                  'Solicitar un repuesto para mi vehículo'
                else
                  'Registro de usuarios'
                end
    when 'devise/unlocks'
      @title += 'Solicitar desbloqueo de cuenta'
    when 'devise/passwords'
      @title += 'No recuerdo mi clave'
    when 'dashboard'
      @title += 'Panel de control'
    when 'replacement_requests'
      @title += 'Lista de solicitudes de repuestos'
    when 'replacement_proposals'
      @title += 'Lista de propuestas de repuestos'
    when 'shops'
      @title += 'Mis locales comerciales'
    else
      @title = ''
    end

    @enable_fb_chat = false

    @enable_fb_chat = true if params[:controller] == 'home'

    @enable_fb_chat = true if params[:controller] == 'dashboard' && %w[shop index].include?(params[:action])
  end

  def states_provinces
    render json: CS.states(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state_province], params[:country]).to_json
  end

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
