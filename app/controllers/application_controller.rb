class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes=Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb:new
  end


  get '/recipes/:id/edit' do
    @recipe=Recipe.find_by_id(params[:id].to_i)

    erb :edit
  end

  get '/recipes/:id' do
    @recipe=Recipe.find_by_id(params[:id].to_i)

    erb :show
  end


  post '/recipes' do
    @recipe=Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipe.save

    redirect  "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    recipe=Recipe.find_by_id(params[:id])
    recipe.update(name: params[:name])
    recipe.update(ingredients: params[:ingredients])
    recipe.update(cook_time: params[:cook_time])
    recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe=Recipe.find_by_id(params[:id].to_i)
    @recipe.destroy

    redirect to '/recipes'
  end
end
