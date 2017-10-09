class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

    get '/users/new' do
      erb :'users/signup'
    end

    post '/users/new' do
      user = User.create(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name], birthday: params[:birthday])

      if user.save && params[:email] != "" && params[:first_name] != "" && params[:last_name] != "" && params[:birthday] != ""
        session[:user_id] = user.id
        redirect '/users/profile'
      else
        redirect '/users/new'
      end
    end

    get '/users/profile' do
      #binding.pry
      @user = Helper.current_user(session)
      @posts = []
       Post.all.each do |post|
         if post.user_id == @user.id
           @posts << post
         end
       end
      erb :'users/profile'
    end


end
