class ReplacementRequestsController < ApplicationController
  before_action :set_replacement_request, only: %i[ ignore ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /replacement_requests or /replacement_requests.json
  def index
    @rr_query = ReplacementRequest.accessible_by(current_ability).order(id: :desc).ransack(params[:q])
    @replacement_requests = @rr_query.result(distinct: true).includes(:vehicle).where.not(state: ['closed'])
    if current_user.has_role? :shop
      @replacement_requests = @replacement_requests.where.not(id: IgnoredRequest.mine(current_user).map { |ir| ir.replacement_request_id })
    end
  end

  # GET /replacement_requests/closed or /replacement_requests/closed.json
  def closed
    @rr_query = ReplacementRequest.accessible_by(current_ability).order(id: :desc).ransack(params[:q])
    @replacement_requests = @rr_query.result(distinct: true).includes(:vehicle).where(state: 'closed')
    if current_user.has_role? :shop
      @replacement_requests = @replacement_requests.where.not(id: IgnoredRequest.mine(current_user).map { |ir| ir.replacement_request_id })
    end
  end

  # GET /replacement_requests/1 or /replacement_requests/1.json
  def show
    redirect_to replacement_requests_url
  end

  # GET /replacement_requests/new
  def new
    if current_user.vehicles.count == 0
      redirect_to new_vehicle_path, alert: "Primero debe registrar un vehículo."
    end
    @replacement_request = ReplacementRequest.new
    @replacement_request.user_id = current_user.id
  end

  # GET /replacement_requests/1/edit
  def edit
  end

  # POST /replacement_requests or /replacement_requests.json
  def create
    @replacement_request = ReplacementRequest.new(replacement_request_params)
    @replacement_request.user_id = current_user.id
    @replacement_request.state = "created"

    #TODO: Enviar notificaciones

    respond_to do |format|
      if @replacement_request.save
        
        current_user.add_role :customer, @replacement_request
        PushNotificationsHelper::new_request_created(@replacement_request, new_replacement_proposal_path(replacement_request_id: @replacement_request.id))

        # send emails to users without push
        shops_users = User.with_role(:shop).where(onesignal_id: nil);
        if shops_users.count > 0
          shops_users.each do |user|
            ReplacementMailer.new_request user, @replacement_request
          end
        end

        format.html { redirect_to replacement_requests_url, notice: "Solicitud creada correctamente." }
        format.json { render :show, status: :created, location: @replacement_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @replacement_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replacement_requests/1 or /replacement_requests/1.json
  def update
    respond_to do |format|
      if @replacement_request.update(replacement_request_params)
        format.html { redirect_to replacement_requests_url, notice: "Solicitud actualizada correctamente." }
        format.json { render :show, status: :ok, location: @replacement_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @replacement_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replacement_requests/1 or /replacement_requests/1.json
  def destroy
    @replacement_request.destroy
    respond_to do |format|
      format.html { redirect_to replacement_requests_url, notice: "Solicitud eliminada correctamente." }
      format.json { head :no_content }
    end
  end

  # GET /replacement_requests/1/ignore or /replacement_requests/1/ignore.json
  def ignore
    IgnoredRequest.create(user: current_user, replacement_request: @replacement_request)
    redirect_to replacement_requests_url, warning: "Solicitud ignorada correctamente."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replacement_request
      @replacement_request = ReplacementRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def replacement_request_params
      params.require(:replacement_request).permit(:user_id, :vehicle_id, :part_number, :short_name, :description, photos: [])
    end
end
