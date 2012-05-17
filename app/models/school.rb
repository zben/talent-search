require "spreadsheet/excel"

class School
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :name_ch
  field :name_en
  field :country_name
  
  belongs_to :province
  belongs_to :country
#  has_many :educations

  def self.populate
    School.delete_all
    Spreadsheet.client_encoding = "UTF-8"
    data = Spreadsheet.open "db/base_data/university_list.xls"
    data.worksheets.each do |sheet|

      sheet.each do |row|
        School.create(name_ch: row[0], name_en: row[0], country_name: sheet.name) if row[0]
      end
    end
  end
end
