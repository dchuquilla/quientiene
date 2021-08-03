class ReplacementRequestsController < ApplicationController
  before_action :set_replacement_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /replacement_requests or /replacement_requests.json
  def index
    @replacement_requests = ReplacementRequest.all.order(id: :desc)
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

    #TODO: Enviar notificaciones

    respond_to do |format|
      if @replacement_request.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replacement_request
      @replacement_request = ReplacementRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def replacement_request_params
      params.require(:replacement_request).permit(:user_id, :vehicle_id, :part_number, :short_name, :description)
    end
end
