class CategoryController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        categories = Category.all
        render json: categories
    end

    def add
        category = Category.create(category_name: params[:category_name])
        render json: category
    end

    def findById
        c = Category.find(params[:category_id])
    end
end
