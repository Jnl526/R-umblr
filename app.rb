require "sinatra"
require "sinatra/activerecord"
require 'sinatra/base'

require_relative './models/user'
require_relative './models/post'
require_relative './models/postTag'
require_relative './models/tag'

require_relative './controllers/users_controller'

set :database, {adapter: 'postgresql', database: 'about_nothing'}
enable :sessions

get '/' do
    @posts = Post.all
    erb :index
end



#  posts 

get '/posts' do
    @posts = Post.all
    erb :"/posts/show"
end

# edit post 
put '/post/:id/edit' do
    @post = Post.find(params[:id])
    @post.update(title: params[:title], user: params[:user], featured_image: params[:featured_image], content: params[:content])
    erb :"/posts/edit"
end

# creat new post 
put '/post/new' do
    if logged_in?
    @newpost = Post.create(title: params[:title], user: params[:user], featured_image: params[:featured_image], content: params[:content])
    erb :"/posts/new"
    else
        redirect "/user/login"
    end
end

# signup/login

get '/signup' do
    erb :"/user/signup"
end

get '/login' do
    erb :"/user/login"
end

get '/dashboard' do
    if !session[:id].nil? 
        @user = User.find(session[:id])
    else
        @user = User.first
    end 
    erb :"/dash/dashboard", layout: :"/dash/layout_dash"
end

get '/logout' do
    session.clear
    redirect '/'
end

post '/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        redirect '/dashboard'
    else   
        #Could not find this user. Redirecting them to the signup page
        redirect '/signup'
    end 
end

post '/user/new' do 
    #Creating a new user based on the values from the form
    @newuser = User.create(name: params[:name], email: params[:email], password: params[:password])
    #Setting the session with key of ID to be equal to the users id
    #Essentialy this "Logs them in"
    session[:id] = @newuser.id
    redirect '/'
end

private 

helpers do
    def user_exists?
        (session[:id] != nil) ? true : false
    end

    def current_user
        User.find(session[:id])
    end

    def current_user_id
        session[:id]
    end
end
