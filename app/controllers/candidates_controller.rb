class CandidatesController < ApplicationController
  # Save duplicated effort
  before_action :find_candidate, only: [:edit, :update, :destroy, :vote]

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      # success
      redirect_to candidates_path, notice: "新增候選人成功!"
    else
      # failure
      render :new
    end
  end

  def edit
    # @candidate = Candidate.find_by(id: params[:id]
  end

  def update
    # @candidate = Candidate.find_by(id: params[:id])

    #if @candidate.update(candidate_params)
    if @candidate.update_attributes(candidate_params)
      # success
      redirect_to candidates_path, notice: "資料更新成功!"
    else
      # failure
      render :new
    end
  end

  def destroy
    # @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "候選人資料已刪除!"
  end

  def vote
    # @candidate = Candidate.find_by(id: params[:id])
    # original codes
    # @candidate.increment(:votes)
    # @candidate.save
    # rewrite to below
    @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
    redirect_to candidates_path, notice: "完成投票!"
  end

  # Strong Parameters
  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

  # remove duplicated codes
  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end
