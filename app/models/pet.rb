require 'httparty'
require 'uri'

class Pet < ApplicationRecord
  include HTTParty
  base_uri = 'https://api.rescuegroups.org/http/'

  def initialize
    @headers = {
      'Content-Type' => 'application/json',
    }
  end

  def self.species
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animalSpecies",
      objectAction: "publicList"
    }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    species = []
    response.parsed_response["data"].each_pair do |key, value|
      species << key
    end
    species
  end

  def self.statuses
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animals",
      objectAction: "getPublicStatuses"
    }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    response.parsed_response
  end

  def self.search(options)
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animals",
      objectAction: "publicSearch",
      search: {
        resultStart: 0,
        resultLimit: 15,
        resultSort: "animalID",
        resultOrder: "asc",
        calcFoundRows: "Yes",
        filters: [
          {
            fieldName: "animalStatus",
            operation: "equals",
            criteria: "Available",
          },
          {
            fieldName: "animalSpecies",
            operation: "equals",
            criteria: options["animalSpecies"],
          },
          {
            fieldName: "animalLocation",
            operation: "equals",
            criteria: options["animalLocation"]["zipcode"],
          },
          {
            fieldName: "animalLocationDistance",
            operation: "radius",
            criteria: options["animalLocationDistance"]["radius"],
          },
        ],
      fields: [ "animalID","animalOrgID","animalName","animalBreed","animalLocation", "animalDescriptionPlain", "animalPictures" ]
    }
  }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    response.parsed_response["data"]
  end

  def self.pictures(animalID)
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animals",
      objectAction: "pictures",
      values: [
        {
          animalID: animalID
        }
      ]
    }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    response.parsed_response
  end

  def self.find(animalID)
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animals",
      objectAction: "publicSearch",
      search: {
        resultStart: 0,
        resultLimit: 1,
        resultSort: "animalID",
        resultOrder: "asc",
        calcFoundRows: "Yes",
        filters: [
          {
            fieldName: "animalID",
            operation: "equals",
            criteria: animalID,
          },
        ],
      fields: [ "animalID","animalOrgID","animalName","animalBreed","animalLocation", "animalDescriptionPlain", "animalPictures" ]
    }
    }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    response.parsed_response
  end
end
