class ReplacementProposalsController < ApplicationController
  before_action :set_replacement_proposal, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /replacement_proposals or /replacement_proposals.json
  def index
    #@replacement_proposals = ReplacementProposal.all
  end

  # GET /replacement_proposals/1 or /replacement_proposals/1.json
  def show
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

    respond_to do |format|
      if @replacement_proposal.save
        format.html { redirect_to @replacement_proposal, notice: "Replacement proposal was successfully created." }
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
        format.html { redirect_to @replacement_proposal, notice: "Replacement proposal was successfully updated." }
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
      format.html { redirect_to replacement_proposals_url, notice: "Replacement proposal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replacement_proposal
      #@replacement_proposal = ReplacementProposal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def replacement_proposal_params
      params.require(:replacement_proposal).permit(:user_id, :shop_id, :name, :price, :original, :brand, :origin, :life_time, :target, :delivery_time, :conditions)
    end
end
