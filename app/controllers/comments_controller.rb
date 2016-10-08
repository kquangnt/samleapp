class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
	def create
  	@comment = current_user.comments.new comment_params
  	@comment.save
  	redirect_to micropost_path(comment_params[:micropost_id])
  end

  def destroy
    @comment.destroy
    redirect_to request.referrer || micropost_path(comment_params[:micropost_id])
  end

  private
  	def comment_params
  		params.require(:comment).permit(:content, :user_id, :micropost_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to micropost_path(comment_params[:micropost_id]) if @comment.nil?
    end
end
