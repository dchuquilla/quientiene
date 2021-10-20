class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to dashboard_shop_path if current_user.has_role?(:shop)
    @my_vehicles = current_user.vehicles.count
    @my_requests = current_user.replacement_requests.pending.count
    @my_c_requests = current_user.replacement_requests.closed.count
  end

  def shop
    @title += ' Empresas'
    redirect_to new_shop_path, alert: 'Por favor registre un local' if current_user.shops.count == 0
    @my_shops = current_user.shops.count
    @pending_requests = ReplacementRequest.pending.count
    @accepted_proposals = ReplacementProposal.accepted.count
  end
end
