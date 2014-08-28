class Municipality
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :title, type: String
  has_many :distincts, :dependent => :destroy
  
  has_many :areas, :dependent => :destroy
  field :coordinates, type: String
  field :vk_group, type: String
  
  rails_admin do
      edit do
        field :distincts, :select2
      end
    end
end


