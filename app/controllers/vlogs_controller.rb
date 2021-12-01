require 'securerandom'

class VlogsController < ApplicationController
  before_action :set_vlog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /vlogs or /vlogs.json
  def index

    #@vlogs = Vlog.all.order('updated_at DESC')
    #add pagination
    @vlogs = Vlog.paginate(page: params[:page], per_page: 3).order('updated_at DESC')
    #to combine sql, comment out one line above
    #@vlogs = Vlog.includes(:user, :comments, :likes).paginate(page: 
    #  params[:page], per_page: 3).order('updated_at DESC')
  end

  # GET /vlogs/1 or /vlogs/1.json
  def show
    @vlog = Vlog.includes(:likes).find_by(id: params[:id])
    
    @vlog_comments = @vlog.comments.paginate(page: params[:page], per_page: 3).order('created_at DESC')
    #to combine sql, comment out on one line above
    #@vlog_comments = @vlog.comments.includes(:user).paginate(page: params[:page], per_page: 3).order('created_at DESC')
    
    @vlog_likes = @vlog.likes.length()
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
    redirect_to vlogs_path, notice: "Not Authorized To Edit This Vlog!" if @vlog.nil?
    #
    #
  end

  # POST /vlogs or /vlogs.json
  def create
    if user_signed_in?
      @vlog = current_user.vlogs.build(vlog_params)
    else
      @vlog = Vlog.new(vlog_params)
    end
    @vlog.file_uuid, @vlog.file_type = handle_uploaded_file(params)
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
    params.require(:vlog)[:file_uuid], params.require(:vlog)[:file_type] = handle_uploaded_file(params)
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
      params.require(:vlog).permit(:title, :content, :user_name, :user_id, :file_uuid, :file_type)
    end

    def handle_uploaded_file(params)
      uploaded_file = params.require(:vlog)[:file]
      if uploaded_file == nil
        return ""
      end
      uploaded_file_id = SecureRandom.uuid
      path = Rails.root.join('public', 'uploads', uploaded_file_id)
      File.open(path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      require "pp"
      file_type = IO.popen(["file", "--brief", "--mime-type", path.to_s], in: :close, err: :close).read.chomp
      if /image/.match(file_type) != nil
        file_type = "image"
      end
      if /video/.match(file_type) != nil
        file_type = "video"
      end
      return uploaded_file_id, file_type
    end
    
end
