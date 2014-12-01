class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  helper_method :current_user, :verify_login

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def verify_login
  	if session[:user_id].nil?
  		redirect_to root_path
  		flash[:alert] = 'Usuário não autenticado.'
  	end
  end
end
