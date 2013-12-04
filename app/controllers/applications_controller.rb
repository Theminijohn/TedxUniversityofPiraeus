class ApplicationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  before_action :check_application_existence, only: [:new, :create]

  # CanCan
  load_and_authorize_resource

  # GET /applications
  # GET /applications.json
  def index
    if current_user.has_role? :admin
    @applications = Application.all
    else
    redirect_to root_path
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = current_user.build_application
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = current_user.build_application(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, alert: 'Your application was successfully created.' }
        format.json { render action: 'show', status: :created, location: @application }
      else
        format.html { render action: 'new' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, alert: 'Your application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:first_name, :last_name, :phone, :speakers, :user_id, :email, :concept, :tell_us,
                                          :cvq, :avatar)
    end

    def check_application_existence
      redirect_to root_path, alert: "You already Submitted an Application" if current_user.application
    end
end
