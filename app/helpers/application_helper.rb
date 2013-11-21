module ApplicationHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def master_name(obj)
    obj ? obj.name : ''
  end

  def render_new_icon
    content_tag(:i,nil,class: 'glyphicon glyphicon-plus')
  end
end
