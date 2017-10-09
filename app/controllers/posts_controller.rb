class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  post '/posts/new' do
    @post = Post.create(content: params[:content], user_id: Helper.current_user(session).id)
    redirect "/posts/#{@post.id}"
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    erb :'posts/show_post'
  end



end
