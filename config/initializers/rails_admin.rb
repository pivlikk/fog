#encoding: utf-8
RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.model 'Area' do
    label "Участок"
    label_plural "Участки"
    list do
      field :area_number
      field :municipality
      field :distinct
      field :including_addresses
      field :street
      field :home_numbers
    end
  end
  
  config.model 'Distinct' do
    label "Округ"
    label_plural "Округа"
    list do
      field :title
      field :municipality
      field :distinct_number
      
    end
  end
  
  config.model 'Municipality' do
    label "Муниципалитет"
    label_plural "Муниципалитеты"
    list do
      field :title
      field :vk_group
    end
  end
  
  config.model 'Candidate' do
    label "Кандидат"
    label_plural "Кандидаты"
    list do
      field :full_name do
        label "ФИО"
      end
      field :distinct do
        label "Округ"
      end
      field :municipality do
        label "Муниципалитет"
      end
      
      
    end
    
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
