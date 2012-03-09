class Notifier < ActionMailer::Base
  default :from=>ActionMailer::Base.smtp_settings[:user_name],
    :return_path =>ActionMailer::Base.smtp_settings[:user_name]
  
  def to_message(message)
    mail(:to => message.user.email,:subject=>"#{message.title}" ) do |format|
      format.text { render :text => message.content }
      #format.html { render :text => message.content }
    end
  end
end
