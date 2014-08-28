class Distinct
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :title, type: String
  field :distinct_number, type: String
  field :email, type: String
  has_many :candidates
  has_many :areas#, :dependent => :destroy
  
  belongs_to :municipality
  
  
end