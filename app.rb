require "sinatra"
require "sinatra/activerecord"
require 'sinatra/base'
require 'faker'
require 'will_paginate'
require 'will_paginate/active_record'  # or data_mapper/sequel


require_relative './models/User'
require_relative './models/Post'
require_relative './models/PostTag'
require_relative './models/Tag'

require_relative './controllers/users_controller'
require_relative './controllers/login_controller'
require_relative './controllers/posts_controller'
require_relative './controllers/tags_controller'

# set :database, {adapter: 'postgresql', database: 'about_nothing'}

configure do
    enable :sessions
    set :session_secret, "secret"
  end

get '/' do
    @posts = Post.all().order(created_at: :asc).limit(20).paginate(:page => params[:page], :per_page => 6)
    @featured = Post.all.order(created_at: :asc).limit(1)
    @recentposts = Post.all.order(created_at: :desc).limit(3)
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
