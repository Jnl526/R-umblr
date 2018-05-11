require "sinatra"
require "sinatra/activerecord"
require 'sinatra/base'
require 'faker'

require_relative './models/user'
require_relative './models/post'
require_relative './models/postTag'
require_relative './models/tag'

require_relative './controllers/users_controller'
require_relative './controllers/login_controller'
require_relative './controllers/posts_controller'
require_relative './controllers/tags_controller'


# configure do
#     set :database, {adapter: 'postgresql', database: 'about_nothing'}
#     enable :sessions
#     set :session_secret, "secret"
#   end

get '/' do
    @posts = Post.all().order(created_at: :asc).limit(20)
    @featured = @posts.limit(1)
    @recentposts = Post.all.order("created_at DESC").limit(3)
    erb :index
end

# search for profiles/posts
get '/search' do
    if params[:search_by] == 'tag'
        tag = Tag.find_by(name: params[:query])
        if tag
            @posts = tag.posts
        end

    end
    erb :search_results
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
