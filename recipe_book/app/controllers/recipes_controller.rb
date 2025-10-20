class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource except: [:index, :show]
  
  def index
    if user_signed_in?
      @recipes = current_user.recipes
    else
      @recipes = Recipe.all
    end
  end
  
  def show
  end
  
  def new
    @recipe = current_user.recipes.new
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end
  
  def edit
    # Ensure users can only edit their own recipes
    redirect_to recipes_path, alert: "Not authorized" unless @recipe.user == current_user
  end
  
  def update
    if @recipe.user != current_user
      redirect_to recipes_path, alert: "Not authorized"
      return
    end
    
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
    else
      redirect_to recipes_path, alert: "Not authorized"
    end
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
  end
end
