# RailsAdmin config file. Generated on June 03, 2012 14:44
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  require 'i18n'
  I18n.default_locale = :en
  config.current_user_method { current_user } # auto-generated

  config.authenticate_with {}
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  config.main_app_name = ['i5KONG', 'Admin']

# config.model JobPost do
#   object_label_method { :title }
#   edit do
#     field :title
#     field :description
#     field :city
#     field :company_name
#     field :contact_person
#     field :description
#     field :email
#     field :expiration
#     field :industry
#     field :is_official
#     field :job_requirement
#     field :phone_number
#     field :province
#     field :skills
#     field :user
#     field :job_type_cd, :enum do
#       enum { JobPost.job_types_for_select(:value) }
#     end
#     field :salary_cd, :enum do
#       enum { JobPost.salaries_for_select(:value) }
#     end
#     field :years_required_cd, :enum do
#       enum { JobPost.years_requireds_for_select(:value) }
#     end
#     field :company_type_cd, :enum do
#       enum { JobPost.company_types_for_select(:value) }
#     end
#     field :degree_requirement_cd, :enum do
#       enum { JobPost.degree_requirements_for_select(:value) }
#     end
#   end
# end
end

