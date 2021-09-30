class ShopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shop, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /shops or /shops.json
  def index
    #@shops = Shop.all
  end

  # GET /shops/1 or /shops/1.json
  def show
  end

  # GET /shops/new
  def new
    @shop = Shop.new
    @shop.user = current_user
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops or /shops.json
  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user

    respond_to do |format|
      if @shop.save
        
        current_user.add_role :shop, @shop
        
        format.html { redirect_to shops_url, notice: "Local creado correctamente." }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to shops_url, notice: "Local actualizado correctamente." }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: "Local eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.require(:shop).permit(:user_id, :name, :ruc, :phone1, :phone2, :address, :contact_name, :sector, :country, :state_province, :city)
    end
end
