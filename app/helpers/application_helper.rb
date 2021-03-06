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
    #content_tag(:i,nil,class: 'glyphicon glyphicon-plus')
    render_icon('plus')
  end

  def render_action_name
    action_name == 'edit' ? '修改' : '添加'
  end

  def render_home_h
    Time.now.strftime("%Y年/%m月 ") + '账单信息'
  end

  def render_icon(icon, options={})
    content_tag(:i, options[:content], class: "glyphicon glyphicon-#{icon}")
  end

  def is_render_slider_settings?
    ['items','accounts','people'].include? controller_name
  end

  def render_ajax_tr_remove_link(obj)
    link_to render_icon(:remove), obj, :confirm => '确定删除？',
        remote: true, :method => :delete, class: 'ajax-remove-tr',
        data:{:type=>:json, 'remove-id'=> obj.to_param}
  end

  def render_bill_select_tag(records,options={},options_html={})
    # return if bill_type_id.blank?
    if records.class.to_s.starts_with?('Mongoid')
      records = records.map{|record|[record.name,record.id]}
    elsif records.first.is_a?(String)
      records = (0...records.size).map{ |i| [records[i], i] }
    end
    select options.delete(:object), options.delete(:method), records,
    {:include_blank => false}.merge(options), {:class => "chosen btn #{options_html.delete(:class)}",
       :style => "width:100%;"}.merge(options_html)
  end

  def render_admin_nav
    str = ''
    if can? :manage, WeixinUser
      str << content_tag('li') do 
        link_to 'WeixinUser', weixin_users_path
      end
    end
    if can? :manage, Material
      str << content_tag('li') do 
        link_to 'Material', materials_path
      end
    end
    raw str
  end
  
  def login_user?
    @current_user.is_a? User
  end

end
