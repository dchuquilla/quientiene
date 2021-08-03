class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @my_vehicles = current_user.vehicles.count
    @my_requests = current_user.replacement_requests.count
    @my_a_requests = current_user.replacement_requests.where(state: "answered").count
  end

  def shop
  end
end
