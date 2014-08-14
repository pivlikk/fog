RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  
  config.model 'Area' do
    list do
      field :area_number
      field :including_addresses
    end
  end
  
  config.model 'Distinct' do
    list do
      field :title
      field :distinct_number
    end
  end
  
  config.model 'Municipality' do
    list do
      field :title
      field :vk_group
    end
  end
  
  config.model 'Candidate' do
    list do
      field :full_name
      field :birthday
      field :organization
      field :email
      
      
    end
  end
  
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
