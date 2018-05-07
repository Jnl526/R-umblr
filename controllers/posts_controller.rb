require "./app"

#********* Posts *********#

# Show posts all by user 

get '/allposts/:id' do
  if user_exists?
    @user = current_user
    @poster = User.find(params[:id])
    @posts = Post.where(user_id: @poster.id)
    erb :'posts/all', layout: :"/user/layout_dash"
else
  # if user doesn't exist
  erb :'user/none'
end
end

# create new post 
get '/post/new' do
    if user_exists?
        @user = current_user
        @tags = Tag.all
        erb :"/posts/new", layout: :"/user/layout_dash"
    else
        redirect "/login"
    end 
    
end

post '/post/new' do
  if user_exists?
      @user = current_user
      post = Post.create(title: params[:title], featured_img: params[:featured_img], content: params[:content], user_id: @user.id)
     
      # create/add tags to post 

      tags = params[:tags]
      @tags = Tag.find_by(name: tags)
        if @tags.nil?
          new_tag = Tag.create(name: tags)
          tag_id = new_tag.id
        else
          tag_id = @tags.id
        end
     PostTag.create(post_id: post.id, tag_id: tag_id)
     
    post.save
    redirect "/post/#{post.id}" 
  end
    erb :"/posts/new"
end

#show post by id

  get '/post/:id' do
    @post = Post.find(params[:id])  
    erb :'posts/show'
  end

#edit specific post if logged in and correct user

get '/post/:id/edit' do
    @user = current_user
    @post = Post.find(params[:id])

    if user_exists?
      if @post.user_id == current_user_id
        @tags = Tag.all
        erb :"/posts/edit", layout: :"/user/layout_dash"
      else
        erb :'posts/show'
      end
    else
      redirect to '/users/login'
    end
    
  end

  put '/post/:id' do
  if user_exists? 
    @post = Post.find(params[:id])
    @post.update(title: params[:title], featured_img: params[:featured_img], content: params[:content])
    
    # create/add tags to existing post 
    tags = params[:tags]
      @tags = Tag.find_by(name: tags)
        if @tags.nil?
          new_tag = Tag.create(name: tags)
          tag_id = new_tag.id
        else
          tag_id = @tags.id
        end
     PostTag.create(post_id: @post.id, tag_id: tag_id)
    redirect "/post/#{@post.id}"
end
end

# delete post 
delete '/post/:id' do 
    @user = current_user
    Post.destroy(params[:id])
    redirect "/allposts/#{@user.id}"
end 