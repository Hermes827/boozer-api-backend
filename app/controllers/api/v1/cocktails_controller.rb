module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        render json: Cocktail.all
      end

      def new
        @cocktail = Cocktail.new
      end

      def create

        proportions = cocktail_params[:proportions]
        cocktail_params[:proportions] = nil
        @cocktail = Cocktail.create(
          name: cocktail_params[:name],
          description: cocktail_params[:description],
          instructions: cocktail_params[:instructions],
          source: cocktail_params[:source],
          proportions: []
        )
        ingredient = @cocktail.ingredients.create(name: proportions[0][:ingredient])
        @cocktail.proportions.create(ingredient: ingredient, amount: proportions[0][:amount])


        if @cocktail.save
          render json: @cocktail, status: :accepted #here is the error, accepted
        else
          render json: { errors: @cocktail.errors.full_messages }, status: :unprocessible_entity
        end
      end

      def show
        cocktail = Cocktail.find(params[:id])

        cocktail_json = {
          id: cocktail.id,
          name: cocktail.name,
          description: cocktail.description,
          instructions: cocktail.instructions,
          source: cocktail.source,
          proportions: cocktail.proportions.map do |prop|
            {
              id: prop.id,
              ingredient_name: prop.ingredient.name,
              amount: prop.amount
            }
          end
        }

        render json: cocktail_json
      end

      # def create
      #   byebug
      # end

      def edit

      end

      def update

      end

      def destroy

      end

      private

      def cocktail_params
        # params.permit(:title, :content)
        params.require(:cocktail).permit!
      end
    end
  end
end
