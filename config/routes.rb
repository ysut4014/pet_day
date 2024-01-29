Rails.application.routes.draw do

  root 'public/homes#top'

  # 顧客用
devise_for :users, controllers: {
  sessions: 'public/sessions'
}
 namespace :public do
  # フォロー関連
  resources :follows, only: [:create, :destroy]

  # ユーザー関連
  resources :users, only: [:show, :edit, :update]

  # いいね関連

  # コメント関連
  resources :comments, only: [:create, :destroy] do
    resources :comment_replies, only: [:create, :destroy], shallow: true
  end

  # 通知関連
  resources :notifications, only: [:index, :new, :create]
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end
  
  get 'home/about', to: 'homes#about', as: 'user_homes_about'

  # 管理者用
devise_for :admins, controllers: {
  sessions: 'admin/sessions'
}

  # 管理者用のルート
  namespace :admin do
    root 'homes#top'
    
    get 'top', to: 'homes#top', as: 'top'

    # フォロー関連
    resources :follows, only: [:create, :destroy]

    # ユーザー関連
    resources :users, only: [:index, :show, :edit, :update]

    # いいね関連
    resources :likes, only: [:create, :destroy]
    
    resources :posts

    # コメント関連
    resources :comments, only: [:create, :destroy] do
      resources :comment_replies, only: [:create, :destroy], shallow: true
    end

    # 通知関連
    resources :notifications, only: [:index, :destroy]
  end
  
  # その他のルートも追加...

  # public/registrationsに対するコントローラを生成する場合
  get 'public/registrations', to: 'public/registrations#index'
end
