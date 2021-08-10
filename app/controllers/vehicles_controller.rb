class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /vehicles or /vehicles.json
  def index
    #@vehicles = Vehicle.all #already loaded user vehicles by cancancan
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
    redirect_to vehicles_path
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
    @vehicle.user_id = current_user.id
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user_id = current_user.id

    respond_to do |format|
      if @vehicle.save

        current_user.add_role :customer, @vehicle

        format.html { redirect_to vehicles_url, notice: "Vehículo creado correctamente." }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    @vehicle.user_id = current_user.id
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicles_url, notice: "Vehículo editado correctamente." }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: "Vehículo eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      #@vehicle = Vehicle.find(params[:id]) #already loaded user vehicle by cancancan
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:user_id, :plate, :chasis, :brand, :model, :year)
    end
end
