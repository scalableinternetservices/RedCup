class VlogsController < ApplicationController
  before_action :set_vlog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /vlogs or /vlogs.json
  def index
    @vlogs = Vlog.all
  end

  # GET /vlogs/1 or /vlogs/1.json
  def show
  end

  # GET /vlogs/new
  def new
    if user_signed_in?
      @vlog = current_user.vlogs.build
    else
      @vlog = Vlog.new
    end
  end

  # GET /vlogs/1/edit
  def edit
  end

  def correct_user
    @vlog = current_user.vlogs.find_by(id: params[:id])
    redirect_to vlogs_path, notice: "Not Authorized To Edit This Vlog! #{params}" if @vlog.nil?
  end

  # POST /vlogs or /vlogs.json
  def create
    if user_signed_in?
      @vlog = current_user.vlogs.build(vlog_params)
    else
      @vlog = Vlog.new(vlog_params)
    end

    respond_to do |format|
      if @vlog.save
        format.html { redirect_to @vlog, notice: "Vlog was successfully created." }
        format.json { render :show, status: :created, location: @vlog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vlogs/1 or /vlogs/1.json
  def update
    respond_to do |format|
      if @vlog.update(vlog_params)
        format.html { redirect_to @vlog, notice: "Vlog was successfully updated." }
        format.json { render :show, status: :ok, location: @vlog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vlogs/1 or /vlogs/1.json
  def destroy
    @vlog.destroy
    respond_to do |format|
      format.html { redirect_to vlogs_url, notice: "Vlog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vlog
      @vlog = Vlog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vlog_params
      params.require(:vlog).permit(:title, :content, :user_name, :user_id)
    end
end
