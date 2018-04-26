require "sinatra"
require "sinatra/activerecord"
require_relative './models/author'
require_relative './models/post'
require_relative './models/postTag'
require_relative './models/tag'

set :database, {adapter: 'postgresql', database: 'about_nothing'}
enable :sessions

get '/' do
    @posts = Post.all
    erb :index
end

# create author profile page

get '/profile' do
    erb: "/author/profile"
end

# edit author profile page
put '/profile/:id' do
    @profile = Author.find(params[:id])
    @profile.update(first_name: [params[:first_name], last_name: [params[:last_name], birthday: [params[:birthday], email: [params[:email], password: [params[:password], avatar: [params[:avatar] )
    erb: "/author/profile"
end

#  posts 

get '/posts' do
    @posts = Post.all
    erb: "/posts/show"
end

# edit post 
put '/post/:id/edit' do
    @post = Post.find(params[:id])
    @post.update(title: [params[:title], author: [params[:author], featured_image: [params[:featured_image], content: [params[:content])
    erb: "/posts/edit"
end

# creat new post 
put '/post/new' do
    if logged_in?
    @newpost = Post.create(title: [params[:title], author: [params[:author], featured_image: [params[:featured_image], content: [params[:content])
    erb: "/posts/new"
    else
        redirect "/author/login"
end

# signup/login

get '/signup' do
    erb: "/author/signup"
end

get '/login' do
    erb: "/author/login"
end

get '/logout' do
    sessions.clear
    redirect "/author/login"
end

private 

def author_exists?
    (session[:id] != nil) ? true : false
end

def current_author
    Author.find(params[:id])
end