class RecipesController < ApplicationController
    
    def index
        recipes = Recipe.all
        if @current_user
            render json: recipes, include: [:user], status: :created
        else
            render json: {error: "Unauthorized"}, status: :unauthorized
        end
    end

    def create
        if @current_user
            recipe = Recipe.create(recipe_params)
            if recipe.valid?
                render json: recipe, include: [:user], status: :created
            else
                render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {error: "Unauthorized"}, status: :unauthorized
        end
    end


    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
