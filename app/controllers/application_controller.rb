class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
