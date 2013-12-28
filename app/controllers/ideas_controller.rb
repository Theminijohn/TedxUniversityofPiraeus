class IdeasController < ApplicationController

  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :check_idea_existence, only: [:new, :create]

  # CanCan
  load_and_authorize_resource

  # GET /ideas
  # GET /ideas.json
  def index
    if current_user.has_role? :admin
      @ideas = Idea.all
    else
      redirect_to root_path
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
  end

  # GET /ideas/new
  def new
    @idea = current_user.build_idea
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.build_idea(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully submitted.' }
        format.json { render action: 'show', status: :created, location: @idea }
      else
        format.html { render action: 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:full_name, :email, :title, :body, :specs)
    end

    def check_idea_existence
      redirect_to current_user.idea, alert: "You already Submitted an Idea, but you can edit and add more Ideas to your existing form if you want" if current_user.idea
    end
end
