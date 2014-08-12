class Area
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :name, type: String
  field :area_number, type: String
  field :voting_address, type: String
  field :including_addresses, type: String
  
  
  belongs_to :distinct
  
  
end