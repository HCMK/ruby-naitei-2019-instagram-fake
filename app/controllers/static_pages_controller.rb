class StaticPagesController < ApplicationController
  def home
    @posts = current_user.feed.non_block.create_desc
    @post = current_user.posts.build
    @current_user = current_user
  end
end
