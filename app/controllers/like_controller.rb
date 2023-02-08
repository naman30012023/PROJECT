class LikeController < ApplicationController
    before_action :authorize_request

    def like
        article = Article.find(parmas[:id])
        like = article.likes.find_by(user_id: @current_user.id)
        # user_exist = false
        # for a in Like.all do |L|
        #     if(@current_user.id == a.user_id)
        #         user_exist = true
        #         break
        #     end
        # end
        if(like?)
            like.destroy
            article.nLikes -= 1;
        else
            article.likes.create(user_id: @current_user.id)
            article.nLikes += 1;
        end
        article.save
        render json: article
    end

    def mostLiked
       articles =  Article.order(nLikes: :desc)
        render json: articles
    end
end
