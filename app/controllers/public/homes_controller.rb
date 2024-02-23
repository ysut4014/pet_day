class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: :top

  def about
  end

def top
  if user_signed_in?
    @notifications = current_user.notifications
  else
    @notifications = []
  end
end

end
