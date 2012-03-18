module AuthenticationHelper
  def signed_in?
    begin
      !session[:user_id].nil? && !(User.find(session[:user_id])).nil?
    rescue
      # If database is messsed up, sign out
      session.destroy
      flash[:error] = "Error with database; logged you out."
      return false
    end
  end
  
  def current_user
    if signed_in?
      @current_user ||= User.find(session[:user_id])
    end
    
  end
  
  def ensure_signed_in
    unless signed_in?
      session[:redirect_to] = request.request_uri
      redirect_to(new_session_path)
    end
  end
end