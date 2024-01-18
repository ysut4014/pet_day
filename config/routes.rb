Rails.application.routes.draw do
  root 'public/homes#top'

  # 顧客用
  # URL /customers/sign_in ...
  
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # フォロー関連
  resources :follows, only: [:create, :destroy]

  # ユーザー関連
  resources :users, only: [:show, :edit, :update]

  # いいね関連
  resources :likes, only: [:create, :destroy]

  # コメント関連
  resources :comments, only: [:create, :destroy] do
    resources :comment_replies, only: [:create, :destroy], shallow: true
  end

  # 通知関連
  resources :notifications, only: [:index, :destroy]
  


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # フォロー関連
  resources :follows, only: [:create, :destroy]

  # ユーザー関連
  resources :users, only: [:show, :edit, :update]

  # いいね関連
  resources :likes, only: [:create, :destroy]

  # コメント関連
  resources :comments, only: [:create, :destroy] do
    resources :comment_replies, only: [:create, :destroy], shallow: true
  end

  # 通知関連
  resources :notifications, only: [:index, :destroy]

  # その他のルートも追加...

  # public/registrationsに対するコントローラを生成する場合
  get 'public/registrations', to: 'public/registrations#index'
end
