module ApplicationHelper
  def make_login_link
    if session[:user_id].nil?
      link_to "Sign in", new_session_path
    else
      link_to "Log Out", session_path, method: :delete
    end  
  end
end
