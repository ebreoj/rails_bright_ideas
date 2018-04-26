class LikesController < ApplicationController

  def create
    if not Like.find_by(idea: Idea.find(like_params[:idea]), user: current_user)
      like = Like.new(idea: Idea.find(like_params[:idea]), user: current_user)
      if not like.save
        flash[:errors] = like.errors.full_messages
      end
    end
    redirect_to '/ideas'
  end

  private
    def like_params
      params.require(:like).permit(:idea)
    end
end
