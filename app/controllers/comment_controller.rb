class CommentController < ApplicationController
    before_action :authorize_request

    def comment 
        article = Article.find(params[:id])
        article.nComments += 1
        comment = article.comments.create(user_id: @current_user.id, comment_content: params[:text])
        render json: comment
    end

    def mostCommented
        articles = Article.order(nComments: :desc)
        render json: articles
    end
    
end