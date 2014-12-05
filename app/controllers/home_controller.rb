class HomeController < ApplicationController
  before_action :verify_login, only: [:index]

  # Página principal da aplicação
  def index
    $id_face = session[:token]
    user = User.find_by(:id => session[:user_id])
    $id_user = user.uid
  end

  # Página de login
  def login
  	# Se a seção tiver sido iniciada, o usuário será redirecionado para a página principal
  	if !session[:user_id].nil?
  	  redirect_to controller: 'home', action: 'index'
  	end
  end

  # Página de cadastro
  def signup
  end

  # Função para criar usuário
  def create
  	# Caso o usuário já esteja cadastrado, ele é redirecionado para a página principal
  	user = User.find_by email: params[:email]
  	if user.nil? # Verifica se o resultado da busca é vazio
  	  user = User.new
  	  user.provider = 'aplication' 	# Diferenciação do login do Facebook
  	  user.uid = '000000000000000' 	# Apenas para manter o padrão do usuário do Facebook
  	  user.name = params[:name] 		# Parametro da requisição
  	  user.email = params[:email] 	# Parametro da requisição
  	  user.save						# Cria registro no banco de dados
  	  redirect_to controller: 'home', action: 'index', notice: 'Usuário criado com sucesso'
  	else
  	  redirect_to controller: 'home', action: 'signup', notice: 'Usuário já existe'
  	end 
  end
end
