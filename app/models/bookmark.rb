class Bookmark
  include Mongoid::Document
  
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :user 
end
