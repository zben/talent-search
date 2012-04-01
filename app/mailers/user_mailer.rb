#encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "i5kongtalent@gmail.com"
  
  def message_user(sender, recipient, message)
    @sender = sender
    @recipient = recipient
    @message = message
    mail(:from=>"悟空人才网 <#{sender.email}>", 
         :to => "#{recipient.name} <#{recipient.email}>", 
         :subject => "您收到了#{sender.name}发送的一封邮件")
  end


end
