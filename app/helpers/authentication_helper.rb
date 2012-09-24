module AuthenticationHelper
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user
    if User.exists?(session[:user_id])
      @current_user ||= User.find(session[:user_id])
    elsif session[:user_id]
      session[:user_id] = nil
    end 
  end
  
  def ensure_signed_in
    unless signed_in?
      session[:redirect_to] = request.request_uri
      redirect_to(new_session_path)
    end
  end

  def nonuser_bounce
    unless signed_in?
      redirect_to(root_url)
    end
  end
end