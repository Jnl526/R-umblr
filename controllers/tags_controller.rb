require "./app"

#********* Tags *********#
get '/tags' do
    if user_exists?
    @user = current_user
    @tags = Tag.all
    else
        redirect "/login"
    end
    erb :"/tags/new", layout: :"/user/layout_dash"
end

#********* Create Tag *********#
post '/tags' do

    if user_exists?
    @user = current_user
    @new_tag = Tag.create(name: params[:name])
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