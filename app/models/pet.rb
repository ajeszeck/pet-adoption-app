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

  def self.search
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "animals",
      objectAction: "publicSearch",
      search: {
        resultStart: 0,
        resultLimit: 20,
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
            criteria: "dog",
          },
          {
            fieldName: "animalLocation",
            operation: "equals",
            criteria: "92117",
          },
          {
            fieldName: "animalLocationDistance",
            operation: "radius",
            criteria: "30",
          },
        ],
      fields: [ "animalID","animalOrgID","animalName","animalBreed","animalLocation" ]
    }
  }
    p ENV["RG_API_KEY"]
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
      p response.parsed_response["data"]
  end
end
