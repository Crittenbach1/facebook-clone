class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  post '/likes/new/:id' do
    @liked = false
    PostLike.all.each do |pl|
       like = Like.find(pl.like_id)
       if like.user_id == Helper.current_user(session)
         @liked = true
       end
    end
    if @liked == false
      like = Like.create(user_id: Helper.current_user(session).id)
      PostLike.create(like_id: like.id, post_id: params[:id])
    end
    redirect '/posts/feed'
  end

  post '/likes/delete/:id' do
    PostLike.all.each do |pl|
       like = Like.find(pl.like_id)
       if like.user_id == Helper.current_user(session).id
         pl.delete
       end
    end
    redirect '/posts/feed'
  end

  post '/likes/:id' do

    @likes = []
    PostLike.all.each do |pl|
      if pl.post_id == params[:id].to_i
        @likes << pl.like_id
      end
    end
    @users = []
     @likes.each do |like|
       like = Like.find(like)
       user = User.find(like.user_id)
       @users << user
     end
     erb :'posts/show_likes'
  end


end
