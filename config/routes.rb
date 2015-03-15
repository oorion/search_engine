Rails.application.routes.draw do
  resources :articles
  post "articles/search", to: "articles#search", as: "article_search"

  namespace :api do
    namespace :v1 do
      resources :articles
      post "articles/search", to: "articles#search", as: "article_search"
    end
  end
end
