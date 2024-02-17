# config/routes.rb
Rails.application.routes.draw do
  
  get 'relationships/followings'
  get 'relationships/followers'
  # 顧客用
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
devise_for :admins, controllers: {
  sessions: 'admin/sessions'
}


  root 'public/homes#top'

get '/users/search', to: 'public/users#search'
  
namespace :public do
  # フォロー関連
  resources :relationships, only: [:create, :destroy]
  # ユーザー関連
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # いいね関連
  resources :posts do
    resources :likes, only: [:index, :create, :destroy]
    resources :comments, only: [:create, :destroy] 
    # 必要に応じて追加の投稿関連のルートを追加できます
  end

  # コメント関連
  resources :comments, only: [:create, :destroy, :index] do
    resources :replies, only: [:create, :destroy] # 返信の作成と削除のみを許可
  end

  # 通知関連
  resources :notifications, only: [:index, :new, :create]

  # 'homes' コントローラー内の 'about' ルートを追加
end

  get 'home/about', to: 'homes#about', as: 'user_homes_about'

  # 管理者用


  # 管理者用のルート
  namespace :admin do
    root 'homes#top'
    
    get 'top', to: 'homes#top', as: 'top'

    # フォロー関連
    resources :follows, only: [:create, :destroy]

    # ユーザー関連
    resources :users do
      resources :posts
      member do
        patch 'toggle_active', to: 'users#toggle_active'
      end
    end
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
  get 'admin/registrations', to: 'admin/registrations#index'
end
