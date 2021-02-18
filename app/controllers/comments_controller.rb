class CommentsController < ApplicationController

    def index
        case
        when params[:user_id]
            comments = Comment.where(user_id: params[:user_id])
        when params[:artwork_id]
            comments = Comment.where(artwork_id: params[:artwork_id])
        else
            comments = Comment.all
        end
        render json: comments
    end

    def create
        @comment = Comment.new(comment_params)
        session[:return_to] ||= request.referer
        if @comment.save
            redirect_to session.delete(:return_to)
        else
            redirect_to session.delete(:return_to)
            flash[:notice] = 'Error: Comment not posted.'
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    private

    def comment_params
        params.permit(:user_id, :artwork_id, :body)
    end

end