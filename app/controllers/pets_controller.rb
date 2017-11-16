class PetsController < ApplicationController
  def index
    @species = Pet.species
    @statuses = Pet.statuses
  end

  def search
    p @pets = Pet.search(params)
    @zipcode = params["animalLocation"]["zipcode"]
    @radius = params["animalLocationDistance"]["radius"]
    @species = Pet.species
    @statuses = Pet.statuses
    render "index"
  end

  def search_params
    params.require(:search).permit(:animalSpecies, :animalLocation, :animalLocationDistance)
  end
end
