# encoding: UTF-8
class Education 
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  default_scope all(sort: [[ :end_date, :desc ]])
  as_enum :degree_type, :"专科"=>1,
                        :"学士"=>2,
                        :"硕士"=>3,
                        :"博士"=>4,
                        :"医学博士"=>5,  
                        :"法学博士"=>6, 
                        :"其他"=>7
 
  
  field :school
  field :school_location
  field :program
  field :start_date, type: Date
  field :end_date, type: Date
  field :GPA, type: String
  field :comment
  
  
  attr_accessible :user_id, :school, :school_location, :degree_type, :program, :start_date, :end_date, :GPA, :comment
  validates :school, :degree_type, :program, :start_date, :end_date,  :presence=>true
  validate :start_must_be_before_end_time	

  embedded_in :user


end
