class Admin::NotificationsController < ApplicationController
    before_action :authenticate_admin!
end
