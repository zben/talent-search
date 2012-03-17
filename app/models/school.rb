class School
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_ch
  field :name_en
  field :country_name
  
  belongs_to :province
  belongs_to :country
  has_many :educations

  def self.populate
    School.delete_all
    data = Excel.new('db/base_data/university_list.xls')
    data.sheets.each do |sheet_name|
      data.default_sheet = sheet_name
      1.upto(data.last_row) do |line|
        school_name = data.cell(line,'A')
        School.create(name_ch: school_name, name_en: school_name, country_name: data.default_sheet)
      end 
    end
  end
end
