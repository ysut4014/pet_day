# app/controllers/public_controller.rb
class PublicController < ApplicationController
  def index
    session[:public_data] = "This is public data"
  end
end
