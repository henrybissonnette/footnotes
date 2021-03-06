class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :username_check?
  
  def new
    response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(
        :identifier => "https://www.google.com/accounts/o8/id",
        :required => ["http://axschema.org/contact/email"],
        :return_to => session_url,
        :method => 'POST')
    head 401
  end
  
  def create
    if openid = request.env[Rack::OpenID::RESPONSE]
      case openid.status
      when :success
        ax = OpenID::AX::FetchResponse.from_success_response(openid)
        user = User.where(:identifier_url => openid.display_identifier).first
        user ||= User.create!(:identifier_url => openid.display_identifier,
                             :email => ax.get_single('http://axschema.org/contact/email'))
        session[:user_id] = user.id
        redirect_to(session[:redirect_to] || root_path) 
      when :failure
        render :action => 'problem'
      end
    else
      redirect_to new_session_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to(session[:redirect_to] || root_path)
  end
end
