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
     rescue
       ""
     end

    def start_must_be_before_end_time
      errors.add(:start_date, "开始日期应该在结束日期之前") if
         self.end_date != nil && (self.start_date > self.end_date) 
    end
  end
end

module Mongoid
  module BasicSearch
    extend ActiveSupport::Concern
    def self.included(base)
        base.field :full_text
        base.before_save(:generate_full_text_search)
    end

    module ClassMethods
      def perform_search_on *args, options
        self.class_variable_set('@@attributes_to_index',args)
        self.class_variable_set('@@sub_attributes_to_index' , options)
      end
    end
    module InstanceMethods
      def generate_full_text_search
        full_text =  ""
        self.class.class_variable_get('@@attributes_to_index').map do |attr|
          full_text += " " + self.send(attr).to_s
        end
        self.class.class_variable_get('@@sub_attributes_to_index').map do |key, attr_array|
          attr_array.map do |attr|
            full_text += " " +self.send(key).to_a.map{|x| x.send(attr).to_s}.join(' ')
            puts full_text
          end
        end
        self.full_text = full_text
      end

    end
  end
end

module Mongoid::Document
  include MongoidHack
  include Mongoid::MultiParameterAttributes
end
