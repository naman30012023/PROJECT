Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/articlecategory/index' => 'article_category#index'
  post 'article/add' => 'article#add'
  post 'category/add' => 'category#add'
  post 'user/add' => 'user#add'
  get 'user/index' => 'user#index'
  delete 'article/delete' => 'article#delete'
  get 'article/index' => 'article#index'
end
