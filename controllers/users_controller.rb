require "./app"

# display posts that belong to single user

get '/profile/:id' do
      @poster = User.find(params[:id])
      @posts = Post.where(user_id: @poster.id).order(created_at: :desc).limit(20)
        erb :'user/profile'
  end

    # create user profile page
get '/profile' do
    "hello world"
    if user_exists?
        @user = current_user
    else
        redirect '/login'
    end
    erb :"/user/edit", layout: :"/user/layout_dash"
end

# edit user profile 

put '/profile/:id' do
    @user = current_user
    @profile = User.find(params[:id])
    @profile.update(first_name: params[:first_name], last_name: params[:last_name], birthday: params[:birthday], email: params[:email], password: params[:password], img_url: params[:img_url], info: params[:info], statement: params[:statement])
    

    redirect "/profile"
end 

# delete user profile 

delete '/profile/:id' do 
    User.destroy(params[:id])
    redirect '/'
end
 