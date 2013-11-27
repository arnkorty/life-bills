module BillsHelper
  
  def render_bill_multiple_select_tag(records,options={},options_html={})
    # return if bill_type_id.blank?
    select options.delete(:object), options.delete(:method), records.map{|record|[record.name,record.id]},
      {:include_blank => true}.merge(options), {:class => "chosen btn #{options_html.delete(:class)}",
       :style => "width:100%;", :multiple => true}.merge(options_html)
  end

  # def render_bill_select_tag(records,options={},options_html={})
  #   # return if bill_type_id.blank?
  #   select options.delete(:object), options.delete(:method), records.map{|record|[record.name,record.id]},
  #     {:include_blank => true,}.merge(options), {:class => "chosen btn #{options_html.delete(:class)}",
  #      :style => "width:100%;"}.merge(options_html)
  # end

  def render_items_form
    html = ''
    Settings.bill_types.each{ |key, value|
      html << render('item_form', name: Settings.bill_types_zh[value], name_en: key)
    }
    html.html_safe
  end

  def render_bill_form
    html = ''
    Settings.bill_types.each{ |key, value|
      html << render('bill_form', name: Settings.bill_types_zh[value], name_en: key)
    }
    html.html_safe
  end

  def render_new_bill_link
    html = ''
    # sort bill types
    Settings.bill_types.sort{|v1,v2| v2[1] <=> v1[1]}.each{ |bill_type|      
      html << link_to(("添加" + Settings.bill_types_zh[bill_type[1]] + render_new_icon).html_safe, '',
                  class:'btn btn-info pull-right new-bill',data: {toggle:'modal',target: "##{bill_type[0]}-form"})
    }
    html    
  end

  def render_bill_order(tag, obj)
    html = ''
    html << content_tag(tag) do
      link_to '降序', bills_path(search: params[:search], order: "#{obj}.desc", from: (params[:search] ? nil : 'search'))
    end
    html << content_tag(tag) do
      link_to '升序', bills_path(search: params[:search], order: "#{obj}.asc", from: (params[:search] ? nil : 'search'))
    end
    html
  end

end
