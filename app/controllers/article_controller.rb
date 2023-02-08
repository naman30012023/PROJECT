class ArticleController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        a = Article.all
        render json: a
    end

    def add
        user = User.find(params[:user_id])
        a = user.articles.create(user_params)
        cat_arr = params[:categories]
        cat_arr.each{
            |cat_arr|
            ArticleCategory.create(article_id: a.id, category_id: cat_arr)
        }

        render json: a
    end

    # def add
    #     user = User.find(params[:user_id])
    #     a = user.articles.create(article_content: params[:article_content], article_title: params[:article_title], article_imageURL: params[:url],)
    #     render json: a
    # end


    def update
        article = Article.find(params[:article_id])
        article.article_title = params[:article_title] || article.article_title
        article.article_content = params[:article_content] || article.article_content
        article.createdOn = parmas[:createdOn] || article.createdOn
        article.article_imageURL = parmas[:article_imageURL] || article.article_imageURL
        article.save
        render json: article
    end

    def findById
        article = Article.find(params[:id])
        render json: article
    end

    def delete
        article = Article.find(params[:id])
        render json: article
        ArticleCategory.where(article_id: article.id).each{
            |a|
            a.delete
        }
        article.delete
    end

    def pagination
        pageLimit = 3
        pageNo = params[:page].to_i
        articles = Article.limit(pageLimit).offset((pageNo-1)*pageLimit)
        render json: articles
    end





    private
    def user_params
        params.permit(:article_title, :article_content, :createdOn, :article_imageURL)
    end
end
