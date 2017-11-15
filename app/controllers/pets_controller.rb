class PetsController < ApplicationController
  def index
    @pets = Pet.search
    @allSpecies = Pet.allSpecies
  end

  def search
    @allSpecies = Pet.allSpecies
  end
end
