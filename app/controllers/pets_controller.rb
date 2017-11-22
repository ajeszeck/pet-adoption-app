class PetsController < ApplicationController
  def index
    @species = ["Dog", "Cat"]
    @statuses = Pet.statuses
  end

  def search
    @pets = Pet.search(params)
    @zipcode = params["animalLocation"]["zipcode"]
    @radius = params["animalLocationDistance"]["radius"]
    @species = ["Dog", "Cat"]
    render "index"
  end

  def show
    @id = params[:id]
    p @pet = Pet.find(params[:id])

  end

  private

  def search_params
    params.require(:search).permit(:animalSpecies, :animalLocation, :animalLocationDistance)
  end
end
