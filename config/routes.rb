Rails.application.routes.draw do
  root 'news_items#index'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout',
                                             registration: 'register', sign_up: '/' },
             controllers: {
                 registrations: 'users/registrations',
                 sessions: 'users/sessions'
             }
  devise_scope :user do
    post 'register/one_click' => 'users/registrations#one_click'
  end

  get 'token' => 'application#token'
  get 'current_user' => 'application#_current_user'

  resources :news_items, path: 'news', only: [:index, :show] do
    resources :comments, only: [:index, :create]
    member do
      post 'like'
      post 'dislike'
    end
  end
  resources :categories, actions: [:index]
end
