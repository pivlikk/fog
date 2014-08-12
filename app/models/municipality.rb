class Municipality
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :name, type: String
  has_many :distincts, :dependent => :destroy
  field :coordinates, type: String
  field :vk_group, type: String
end


