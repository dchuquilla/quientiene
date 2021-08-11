class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.has_role?(:shop)
      redirect_to dashboard_shop_path
    end
    @my_vehicles = current_user.vehicles.count
    @my_requests = current_user.replacement_requests.count
    @my_c_requests = ReplacementRequest.answered.count
  end

  def shop
    if current_user.shops.count == 0
      redirect_to new_shop_path, alert: "Por favor registre un local"
    end
    @my_shops = current_user.shops.count
    @pending_requests = ReplacementRequest.pending.count
    @accepted_proposals = ReplacementProposal.accepted.count
  end
end
