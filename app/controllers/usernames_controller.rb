class UsernamesController < ApplicationController
  before_filter :signed_in
  skip_before_filter :has_username


  def new
    redirect_to(root_path) if current_user.has_username?
  end

  def create
    current_user.username = params[:username]
    current_user.save
    # TODO validate uniqueness
    redirect_to(root_path)
  end
end
