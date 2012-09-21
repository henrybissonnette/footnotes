class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  before_filter :has_username

  def has_username
    if signed_in? && !current_user.has_username?
      redirect_to(new_username_path)
    end
  end

  def signed_in
    if !signed_in?
      redirect_to(root_path)
    end
  end
end
