class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/posts/feed' do
    if Helper.is_logged_in?(session) == false
      redirect '/login'
    else
      erb :'posts/feed'
    end
  end

  post '/posts/new' do
    @post = Post.create(content: params[:content], user_id: Helper.current_user(session).id)
    redirect "/posts/#{@post.id}"
  end

  get '/posts/edit/:id' do
    @post = Post.find(params[:id].to_i)
    if @post.user_id != Helper.current_user(session).id
      erb :error
    else
     erb :"posts/edit_post"
    end
  end

  post '/posts/edit/:id' do
    @post = Post.find(params[:id].to_i)
    @post.content = params[:content]
    @post.save
    redirect "posts/#{@post.id}"
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    erb :'posts/show_post'
  end

  post '/posts/delete/:id' do
    @post = Post.find(params[:id].to_i)
    if @post.user_id == Helper.current_user(session).id
      @post.delete
    else
      erb :error
    end
    redirect 'posts/feed'
  end

end
