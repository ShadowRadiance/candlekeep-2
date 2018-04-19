class BranchesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :require_admin!, except: [:show]
  before_action :set_branch, only: [:show, :edit, :update]

  def index
    @branches = Branch.all
  end

  def show; end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to @branch, notice: 'Branch created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @branch.update(branch_params)
      redirect_to @branch, notice: 'Branch updated successfully'
    else
      render :edit
    end
  end

  private

  def set_branch
    @branch = Branch.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit(:name, :address, :phone_number)
  end
end
