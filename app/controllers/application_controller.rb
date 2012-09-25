class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  before_filter :username_check?

  def username_check?
    if signed_in? && !current_user.has_username?
      redirect_to(first_edit_user_path(current_user))
    end
  end
end
