class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
      erb :index
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/users/profile'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session = {}
    redirect '/'
  end

end
