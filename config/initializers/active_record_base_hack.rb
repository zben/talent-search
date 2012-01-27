class ActiveRecord::Base
   def name
      eval("name_#{I18n.locale}")
   end
end

