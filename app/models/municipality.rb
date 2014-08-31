class Municipality
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :title, type: String
  has_many :distincts, :dependent => :destroy
  
  has_many :areas#, :dependent => :destroy
  field :coordinates, type: String
  field :vk_group, type: String

end


