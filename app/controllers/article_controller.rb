class ArticleController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authorize_request
    before_action :find_article, except: :create
    before_action :authenticate, except: :create
    def index   #show all articles on 1 page
        a = Article.all
        render json: a
    end

    def add #add an article under current user. Also updates through table
        a = @current_user.articles.create(user_params)
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


    def update  #update article. Fields not entered are kept as original
        @article.article_title = params[:article_title] || @article.article_title
        @article.article_content = params[:article_content] || @article.article_content
        @article.createdOn = parmas[:createdOn] || @article.createdOn
        @article.article_imageURL = parmas[:article_imageURL] || @article.article_imageURL
        @article.save
        render json: @article
    end

    def findById
        render json: @article
    end

    def delete
        render json: @article
        ArticleCategory.where(article_id: @article.id).each{
            |a|
            a.delete
        }
        @article.delete
    end

    def pagination  #only display 'pageLimit' number of articles on a single
        pageLimit = 3
        pageNo = params[:page].to_i
        articles = Article.limit(pageLimit).offset((pageNo-1)*pageLimit)
        render json: articles
    end

    def findByAuthor
        user = User.find_by(username: params[:author])
        articles = Article.where(user_id: author.id)
        render json: articles
    end

    def partialSearch
        article = Article.where("article_title LIKE ?", "%#{params[:search_text]}%")
        
        b = Article.where("article_content LIKE ?", "%#{params[:search_text]}%")
        arr = []
        arr.push(article)
        arr.push(b)
        render json: arr 
    end


    private
    def find_article
        @article = Article.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
        params.permit(:article_title, :article_content, :createdOn, :article_imageURL)
    end

    def authenticate
        if(@current_user.id != @article.user_id)
            raise "Not Authorized"
        end
    end
            
end
