require "./app"

#********* Tags *********#
get '/tags' do
    if user_exists?
    @user = current_user
    @tags = Tag.all
    erb :"/tags/new", layout: :"/user/layout_dash"
    else
        redirect "/login"
    end
end
#********* Create Tag *********#
post '/tags' do

    if user_exists?
    @user = User.find(session[:id])
    Tag.create(tag_name: params[:tag_name])
    erb :"/tags/new", layout: :"/user/layout_dash"
    else
        redirect "/login"
    end
end


#********* Search *********#
get '/tag/:id' do
    @tag = Tag.find(params[:id])
    erb :"/tags/show"
end