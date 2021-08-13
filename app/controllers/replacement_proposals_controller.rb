class ReplacementProposalsController < ApplicationController
  before_action :set_replacement_request, only: %i[ show edit update new create ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /replacement_proposals or /replacement_proposals.json
  def index
    if params[:replacement_request_id].present?
      @replacement_proposals = @replacement_proposals.where(replacement_request_id: params[:replacement_request_id].to_i)
    end
    if current_user.has_role? :customer
      @replacement_proposals = @replacement_proposals.where.not(id: IgnoredProposal.mine(current_user).map { |ir| ir.replacement_proposal_id })
    end
    @replacement_proposals = @replacement_proposals.order(id: :desc)
  end

  # GET /replacement_proposals/1 or /replacement_proposals/1.json
  def show
    redirect_to replacement_proposals_path(replacement_request_id: @replacement_proposal.replacement_request.id)
  end

  # GET /replacement_proposals/new
  def new
    @replacement_proposal = ReplacementProposal.new
  end

  # GET /replacement_proposals/1/edit
  def edit
  end

  # POST /replacement_proposals or /replacement_proposals.json
  def create
    @replacement_proposal = ReplacementProposal.new(replacement_proposal_params)
    @replacement_proposal.user = current_user

    respond_to do |format|
      if @replacement_proposal.save

        current_user.add_role :shop, @replacement_proposal
        @replacement_proposal.replacement_request.update(state: 'answered')

        format.html { redirect_to replacement_proposals_path(replacement_request_id: @replacement_proposal.replacement_request.id), notice: "Propuesta creada correctamente." }
        format.json { render :show, status: :created, location: @replacement_proposal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @replacement_proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replacement_proposals/1 or /replacement_proposals/1.json
  def update
    respond_to do |format|
      if @replacement_proposal.update(replacement_proposal_params)
        format.html { redirect_to replacement_proposals_path(replacement_request_id: @replacement_proposal.replacement_request.id), notice: "Propuesta actualizada correctamente." }
        format.json { render :show, status: :ok, location: @replacement_proposal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @replacement_proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replacement_proposals/1 or /replacement_proposals/1.json
  def destroy
    @replacement_proposal.destroy
    respond_to do |format|
      format.html { redirect_to replacement_proposals_url, notice: "Propuesta eliminada correctamente." }
      format.json { head :no_content }
    end
  end

  # GET /replacement_proposals/1/ignore or /replacement_proposals/1/ignore.json
  def ignore
    IgnoredProposal.create(user: current_user, replacement_proposal: @replacement_proposal)
    redirect_to replacement_proposals_url(replacement_request_id: params[:replacement_request_id]), warning: "Propuesta ignorada correctamente."
  end

  # GET /replacement_proposals/1/accept or /replacement_proposals/1/accept.json
  def accept
    @replacement_proposal.update(state: 'accepted')
    @replacement_proposal.replacement_request.update(state: 'closed')
    redirect_to closed_replacement_requests_path, warning: "Propuesta aceptada correctamente."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replacement_proposal
      #@replacement_proposal = ReplacementProposal.find(params[:id])
    end

    def set_replacement_request
      if params[:replacement_proposal].present?
        request_id = params[:replacement_proposal][:replacement_request_id]
      else
        request_id = params[:replacement_request_id]
      end
      @replacement_request = ReplacementRequest.find(request_id)
    end

    # Only allow a list of trusted parameters through.
    def replacement_proposal_params
      params.require(:replacement_proposal).permit(:user_id, :shop_id, :replacement_request_id, :name, :price, :original, :brand, :origin, :life_time, :target, :delivery_time, :conditions, photos: [])
    end
end
