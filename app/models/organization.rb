class Organization < ApplicationRecord
  def self.lookup(orgID)
    data = {
      apikey: ENV["RG_API_KEY"],
      objectType: "orgs",
      objectAction: "publicView",
      values: [
        {
          orgID: orgID
        }
      ],
      fields: [ "orgID", "orgLocation", "orgName" ]
    }
    response = HTTParty.post('https://api.rescuegroups.org/http/',
      { headers: @headers, body: data.to_json} )
    response.parsed_response
  end
end
