class PostsController < ApplicationController
	# layout 'users'
  def index
  	@posts = current_user.posts.all
  end
end
