class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index,:new, :create, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /comments or /comments.json
  def index
    #@comments = Comment.all
    @comments = Comment.find_by(vlog_id: params[:vlog_id])
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to Vlog.find(params[:vlog_id]), notice: "Not Authorized To Edit This Vlog!" if @comment.nil?
    ##{params}
  end
  # GET /comments/new
  def new
    @vlog = Vlog.find(params[:vlog_id])
    @comment = @vlog.comments.build
  end

  # GET /comments/1/edit
  def edit
    @vlog = Vlog.find(params[:vlog_id])
    @comment = @vlog.comments.find(params[:id])
  end

  def create
    @vlog = Vlog.find(params[:vlog_id])
    @comment = @vlog.comments.create(params[:comment].permit(:comment))

    if user_signed_in?
      @comment.user_id = current_user.id
    else
      @comment.user_id = 5
    end
    respond_to do |format|
      if @comment.save
        format.html {redirect_to vlog_comment_path(@vlog.id, @comment.id), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  # POST /comments or /comments.json
  #def create
  #  @vlog = Vlog.find(params[:vlog_id])
  #  @comment = @vlog.comments.create(params[:comment].permit(:comment))
#
  #  if @comment.save
  #    redirect_to @vlog, notice: "Comment was successfully created."
  #    render :show, status: :created, location: @comment
  #  else
  #    render :new, status: :unprocessable_entity
  #  end

    #@comment = Comment.new(comment_params)

    #respond_to do |format|
    #  if @comment.save
    #    format.html { redirect_to @comment, notice: "Comment was successfully created." }
    #    format.json { render :show, status: :created, location: @comment }
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @comment.errors, status: :unprocessable_entity }
    #  end
    #end
  #end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @vlog = Vlog.find(params[:vlog_id])
    @comment = @vlog.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to vlog_comment_path(@vlog.id, @comment.id), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @vlog = Vlog.find(params[:vlog_id])
    @comment = @vlog.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to vlog_path(@vlog), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment, :vlog_id, :user_id)
    end
end
