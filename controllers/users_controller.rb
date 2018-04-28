require 'sinatra/base'

class UsersController < Sinatra::Base
        
    # create user profile page
        get '/profile' do
            "hello world"
            if !session[:id].nil? 
                @user = User.find(session[:id])
            else
                @user = User.first
            end 
            erb :"/user/profile"
        end

        # edit user profile 

        put '/profile/:id' do
            @profile = User.find(params[:id])
            @profile.update(first_name: params[:first_name], last_name: params[:last_name], birthday: params[:birthday], email: params[:email], password: params[:password], img_url: params[:img_url], info: params[:info], statement: params[:statement])
            redirect '/profile'
        end 

        # delete user profile 

        delete '/profile/:id' do 
            User.destroy(params[:id])
            redirect '/profile'
        end 
  end