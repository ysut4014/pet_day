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
    resources :posts, only: [:index]
    resource :relationships, only: [:create, :destroy]
    
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :users do
    get 'delete', on: :member # 退会用のルート
    delete 'destroy', on: :member # 退会アクション用のルート
  end
  
resources :users do
  member do
    get 'edit_image'
    patch 'update_image'
  end
end 
  # いいね関連
resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  resources :likes, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy] 
end

  # コメント関連
  resources :comments, only: [:create, :destroy, :index] do
    resources :replies, only: [:create, :destroy] # 返信の作成と削除のみを許可
  end
  # 退会機能
  resources :users do
    get 'delete', on: :member # 退会用のルート
    delete 'destroy', on: :member # 退会アクション用のルート
  end
  # 通知関連
  resources :notifications, only: [:index, :destroy, :create] do
    collection do
      delete :destroy_all
    end
  end
  


  # 'homes' コントローラー内の 'about' ルートを追加
end

  get 'home/about', to: 'homes#about', as: 'user_homes_about'
  delete '/notifications/delete_all', to: 'notifications#delete_all', as: 'delete_all_notifications'
  # 管理者用


  # 管理者用のルート
  namespace :admin do
    root 'homes#top'
    
    get 'top', to: 'homes#top', as: 'top'

    # フォロー関連
    resources :follows, only: [:create, :destroy]

    # ユーザー関連
    resources :users do
      member do
        patch 'toggle_active', to: 'users#toggle_active'
      end
    end
    # いいね関連
    resources :posts do
      delete :delete_all, on: :collection
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    
    
   resources :admin_comments, only: [:destroy]


    resources :posts do
      resources :comments, only: [:destroy]
    end
    # コメント関連
    resources :comments, only: [:create, :destroy] do
      resources :comment_replies, only: [:create, :destroy], shallow: true
    end

    # 通知関連
    resources :notifications, only: [:index, :destroy, :show]
  end
  
  # その他のルートも追加...

  # public/registrationsに対するコントローラを生成する場合
  get 'admin/registrations', to: 'admin/registrations#index'
end
