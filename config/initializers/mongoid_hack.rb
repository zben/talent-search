#encoding: UTF-8
module MongoidHack
  extend ActiveSupport::Concern
  module ClassMethods
     def populate
      require 'csv'
      csv_data = CSV.read "db/base_data/#{self.collection_name}.csv",:encoding=>'utf-8'
      headers = csv_data.shift.map {|i| i.to_sym }
      id_columns = headers.find_all{|item| item=~/id\z/}
      puts id_columns
      string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
      records = string_data.map {|row| Hash[*headers.zip(row).flatten] } 
      records.each do |record|
        id_columns.each do |col| 
          record[col] = record[col].to_i unless record[col].nil? 
        end
        puts record
        self.create(record)
      end 
     end
  end
 
  module InstanceMethods
     def name
      eval("name_#{I18n.locale}")
     end
     
     
    def start_must_be_before_end_time
      errors.add(:start_date, "开始日期应该在结束日期之前") if
         self.end_date != nil && (self.start_date > self.end_date) 
    end 

  end
end

module Mongoid::Document
  include MongoidHack
  include Mongoid::MultiParameterAttributes
  include Mongoid::FullTextSearch
end
