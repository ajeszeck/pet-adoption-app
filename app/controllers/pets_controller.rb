require 'httparty'

class PetsController < ApplicationController
  def index
    @pets = Pet.all.limit(5)
    p @pets
  end
end
