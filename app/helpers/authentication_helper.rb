module AuthenticationHelper
  # TODO move signed in functionality to current user
  def signed_in?
    User.exists?(session[:user_id])
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if signed_in?
  end
  
  def ensure_signed_in
    unless signed_in?
      session[:redirect_to] = request.request_uri
      redirect_to(new_session_path)
    end
  end
end