# app/controllers/admin/users_controller.rb

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  # 他のアクション（show, edit, update, destroy）も必要に応じて追加
end
