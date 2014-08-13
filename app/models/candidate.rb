class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :full_name, type: String
  field :birthday, type: Date
  field :organization, type: String
  field :email, type: String
  field :phone, type: String
  field :twitter, type: String
  field :facebook, type: String
  field :vk, type: String
  
  belongs_to :distinct
  
  
end