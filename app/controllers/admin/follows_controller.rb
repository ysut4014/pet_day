class Admin::FollowsController < ApplicationController
    before_action :authenticate_admin!
end
