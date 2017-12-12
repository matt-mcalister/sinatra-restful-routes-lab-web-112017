class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :show
  end

  # Create a third controller action that uses RESTful routes and renders a form to edit a single recipe.
  # This controller action should update the entry in the database with the changes, and then redirect to the recipe show page
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :edit
  end


  patch '/recipes' do
    params[:id] = params[:id].to_i
    @recipe = Recipe.find(params[:id])
    params.delete("_method")
    @recipe.update(params)
    redirect "/recipes/#{@recipe.id}"
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end


  # Add to the recipe show page a form that allows a user to delete a recipe.
  # This form should submit to a controller action that deletes the entry from the database and redirects to the index page.
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect "/recipes"
  end
end
