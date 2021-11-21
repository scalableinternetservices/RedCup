class LikesController < ApplicationController
  before_action :authenticate_user!, except: []
  def new
    @vlog = Vlog.find(params[:vlog_id])
    @like = @vlog.likes.build
  end

  def create
    @vlog = Vlog.find_by(id: params[:vlog_id])
    @like = current_user.likes.build()
    @like.vlog = @vlog
    # existed = exist_user_in_liked(current_user, @vlog)
    respond_to do |format|
      begin
        if @vlog.user == current_user 
          format.html { redirect_to @vlog, notice: "Nope. You cannot like your vlog!" }
          format.json { render json: "Liked Yourself", status: :unprocessable_entity }
        elsif @like.save
          format.html { redirect_to @vlog, notice: "Vlog liked." }
          format.json { render :show, status: :created, location: @vlog }
        else
          format.html { redirect_to @vlog, notice: "Something wrong." }
          format.json { render json: @vlog.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique
        @vlog.likes.find_by(user: current_user).destroy
        format.html { redirect_to @vlog, notice: "Vlog unliked." }
        format.json { render :show, status: :destroyed, location: @vlog }
      end
      
      
    end
  end
  private
    def click_params
      params.require(:vlog_id)
    end
    def exist_user_in_liked(user, vlog)
      return vlog.likes.find_by(user: user)
    end
end
