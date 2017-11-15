class PetsController < ApplicationController
  def index
    @pets = Pet.search
  end
end
