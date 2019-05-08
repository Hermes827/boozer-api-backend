class CocktailSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions, :source, :proportions
end
