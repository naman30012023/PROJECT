Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  #read all categories
  get '/articlecategory/index' => 'article_category#index'

  #filter by author name
  get '/article/byAuthor' => 'article#findByAuthor'
  #read all articles
  get 'article/index' => 'article#index'
  #search article by partial text or title
  get '/article/partial' => 'article#partialSearch'
  #add an article
  post 'article/add' => 'article#add'
  #delete an article
  delete 'article/delete' => 'article#delete'
  #update article
  put 'article/update' => 'article#update'
  #find article by id
  get 'article/findById/:id' => 'article#findById'
  #pagination with page number in URL
  get 'article/page/:page' => 'article#pagination'


  post 'category/add' => 'category#add'

  get 'user/index' => 'user#index'
  post 'user/add' => 'user#add'
  put 'user/update' => 'user#update'
  delete 'user/delete' => 'user#delete'

  post 'auth/login' => 'authentication#login'
end

