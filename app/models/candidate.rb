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
  
  rails_admin do
    edit do
      field :full_name
      field :birthday
      field :organization
      field :email
      field :phone
      field :twitter
      field :facebook
      field :vk
      field :distinct do
        partial "edit_candidate_distincts"
      end
    end
  end
  
end