class SessionsController < ApplicationController
  # Função em caso de login pelo facebook
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:token] = auth['credentials']['token']
    redirect_to controller: "home", action: "index", notice: "Usuário autenticado"
  end

  # Função em caso de login nativo
  def login
    user = User.find_by email: params[:email] #, password: params[:password]
    if user
      session[:user_id] = user.id
      redirect_to controller: "home", action: "index", notice: 'Usuário autenticado.'
    else
      redirect_to root_url
      flash[:alert] = 'Matrícula ou senha inválidos'
    end
  end

  def new
    redirect_to '/auth/facebook'
  end

  # Função para destruir sessão
  def destroy
  	session[:user_id] =  nil
  	redirect_to root_url, :notice => 'Signed out'
    
    # Em teste, funcionalidade relacionada ao logout do facebook
    # url = 'https://www.facebook.com/logout.php?next=http://localhost:3000/&access_token='
    # url << session[:token]
    # session[:user_id] = nil
    # session[:token] = nil
    # redirect_to (url)
    # redirect_to ("https://www.facebook.com/logout.php", { :next => "http://localhost:3000/" , :access_token => session[:token] } 
    # redirect_to "https://www.facebook.com/logout.php?next=http://localhost:3000/&access_token=#{session[:token}"
  end
end
