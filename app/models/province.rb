class Province
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_ch
  field :name_en
  
  belongs_to :country

  has_many :cities
  

  def self.pinyin_order
    self.all.sort {|a ,b|   a.name_ch.pinyin.join <=> b.name_ch.pinyin.join }
  end
end
