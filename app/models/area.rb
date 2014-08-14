class Area
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
    
  field :name, type: String
  field :area_number, type: String
  field :voting_address, type: String
  field :including_addresses, type: String
  
  belongs_to :municipality
  belongs_to :distinct
  search_in :including_addresses
  
end