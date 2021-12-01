require 'securerandom'
require 'pp'

@expire_val = 100.minutes

class VlogsController < ApplicationController
  before_action :set_vlog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /vlogs or /vlogs.json
  def index
    ##avoid duplicate cache
    if params[:page].nil?
        params[:page] = 1
    end
    #@vlogs = Vlog.all.order('updated_at DESC')
    @vlogs = Rails.cache.fetch("vlogs_page/#{params[:page]}", expires_in: @expire_val) do
          #add pagination
      Vlog.includes(:user, :comments, :likes).paginate(page: params[:page], per_page: 3).order('updated_at DESC').to_a
    end
    #to combine sql, comment out one line above
    #@vlogs = Vlog.includes(:user, :comments, :likes).paginate(page: 
    #  params[:page], per_page: 3).order('updated_at DESC')
  end

  # GET /vlogs/1 or /vlogs/1.json
  def show
    #@vlog = Rails.cache.fetch("vlog/#{params[:id]}", expires_in: @expire_val) do
    #  Vlog.includes(:likes).find_by(id: params[:id])
    #end
    ##avoid duplicate cache
    if params[:page].nil?
      params[:page] = 1
    end
    @vlog_comments = Rails.cache.fetch("vlog_comments/#{params[:id]}/#{params[:page]}", expires_in: @expire_val) do
      @vlog.comments.includes(:user).paginate(page: params[:page], per_page: 3).order('created_at DESC').to_a
    end

    @attachment = @vlog.file
    @actype = @attachment.content_type
    
    #to combine sql, comment out on one line above
    #@vlog_comments = @vlog.comments.includes(:user).paginate(page: params[:page], per_page: 3).order('created_at DESC')
    
    @vlog_likes = Rails.cache.fetch("vlog_likes_count/#{params[:id]}", expires_in: @expire_val) do
      @vlog.likes.length()
    end

    @vlog_comments_count = Rails.cache.fetch("vlog_comments_count/#{params[:id]}", expires_in: @expire_val) do
      @vlog_comments.total_entries
    end
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
    # @vlog.file_uuid, @vlog.file_type = handle_uploaded_file(params)
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
    # params.require(:vlog)[:file_uuid], params.require(:vlog)[:file_type] = handle_uploaded_file(params)
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
      #@vlog = Vlog.find(params[:id])
      @vlog = Rails.cache.fetch("vlog/#{params[:id]}", expires_in: @expire_val) do
            Vlog.includes(:likes, :user).find_by(id: params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def vlog_params
      params.require(:vlog).permit(:title, :content, :user_name, :user_id, :file)
    end

end
