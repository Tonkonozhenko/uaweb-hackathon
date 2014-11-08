Rails.application.routes.draw do
  devise_for :users

  resources :news_items, path: 'news', only: [:index, :show]
end
