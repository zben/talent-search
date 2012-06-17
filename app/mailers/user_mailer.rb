#encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "i5kongtalent@gmail.com"
  
  def message_user(sender, recipient, message)
    @sender = sender
    @recipient = recipient
    @message = message
    mail(:from=>"悟空人才网 <i5kongtalent@gmail.com>", 
         :to => "#{recipient.name} <#{recipient.email}>", 
         :subject => "您收到了#{sender.name}发送的一封邮件")
  end

  def apply_for_job(current_user, job_post, content)
    @applicant = current_user
    @job_post = job_post
    @message = content
    mail(:from=>"悟空人才网 <i5kongtalent@gmail.com>",
         :to=>"#{job_post.email}",
         :subject=>"您收到了#{current_user.name}的职位申请")
  end

  def apply_for_tech(current_user, tech_post, content)
    @applicant = current_user
    @tech_post = tech_post
    @message = content
    mail(:from=>"悟空人才网 <i5kongtalent@gmail.com>",
         :to=>"#{tech_post.email}",
         :subject=>"您收到了#{current_user.name}的项目需求申请")
  end
end
