require "sinatra"
require "sinatra/activerecord"
require_relative './models/author'
require_relative './models/post'
require_relative './models/postTag'
require_relative './models/tag'

set :database, {adapter: 'postgresql', database: 'about_nothing'}
enable :sessions