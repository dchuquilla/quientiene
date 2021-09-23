class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning

  before_action :set_metadata

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def set_metadata
    @title = "QuienTiene, encuentre el repuesto que está buscando"
  end
end
