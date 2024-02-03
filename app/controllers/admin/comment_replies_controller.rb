class Admin::CommentRepliesController < ApplicationController
    before_action :authenticate_admin!
end
