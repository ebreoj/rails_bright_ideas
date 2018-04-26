class IdeasController < ApplicationController

  def index
    @ideas = Idea.all.includes(:likes, :user)
    @ideas_ranked = Idea.joins(:likes).group("ideas.id").order("count(likes.id) desc")
    @current_user = current_user
  end

  def create
    idea = Idea.new(idea_params.merge(user: current_user))
    if not idea.save
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to '/ideas'
  end

  def show
    @idea = Idea.find(params[:id])
  end


  def destroy
    idea = Idea.find(params[:id])
    if not idea.destroy
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to "/ideas"
  end

  private
    def idea_params
      params.require(:idea).permit(:content)
    end
end