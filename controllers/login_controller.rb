require "./app"

#********* Login/Signup *********#

# signup/login

get '/login' do
    erb :"/user/login" , layout: :"/user/layout_cred"
end

get '/dashboard' do
    if !session[:id].nil? 
        @user = current_user
    else
        @user = User.first
    end 
    erb :"/user/dashboard", layout: :"/user/layout_dash"
end

get '/logout' do
    if user_exists?
        session.destroy #log out
        redirect to '/'
      end
end

post '/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        redirect '/profile'
    else   
        
        redirect '/signup'
    end 
end

get '/signup' do
    erb :"/user/signup", layout: :"/user/layout_cred"
end

post '/signup' do 
    #Creating a new user 
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    
    if @newuser.save
    session[:id] = @newuser.id
    redirect '/profile'
  else
    @errors = @newuser.errors
    redirect "/signup"
  end
end

