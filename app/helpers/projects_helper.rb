#encoding: UTF-8
module ProjectsHelper
  def join_project_buttons_code project
    case project.status(current_user) 
    when "new"
      link_to "申请加入", project_apply_path(project.id),:class=>"btn primary"
    when "pending","declined"
      link_to "取消申请", project_quit_path(project.id),:class=>"btn primary"
    when "member"
      link_to "退出项目", project_quit_path(project.id),:class=>"btn primary"
    end
  end
end
