Rails.application.routes.draw do
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

  root 'news_items#index'
  resources :news_items, path: 'news', only: [:index, :show] do
    member do
      post 'like'
      post 'dislike'
    end
  end
end
