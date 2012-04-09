class Usage  
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :find_job, type: Boolean
    field :find_project, type: Boolean
    field :find_partner, type: Boolean
    field :find_money, type: Boolean
    field :meet_people, type: Boolean
    field :browse, type: Boolean
    embedded_in :user
end
