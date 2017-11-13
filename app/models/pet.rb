require 'httparty'

class Pet < ApplicationRecord
  include HTTParty
  def self.search(args)
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "species",
      objectAction: "list",
      search: {
        resultStart: 0,
        resultLimit: 20,
        resultOrder: "asc",
        calcFoundRows: "Yes",
      }
    }

    headers = {
      'Content-Type' => 'application/json',
    }

    response = HTTParty.post 'https://api.rescuegroups.org/http/json',
    headers: headers, body: data.to_json
  end
end
