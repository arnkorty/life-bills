module BillsHelper
  
  def render_bill_multiple_select_tag(records,options={},options_html={})
    # return if bill_type_id.blank?
    select options.delete(:object), options.delete(:method), records.map{|record|[record.name,record.id]},
      {:include_blank => true}.merge(options), {:class => "chosen btn #{options_html.delete(:class)}",
       :style => "width:100%;", :multiple => true}.merge(options_html)
  end

  def render_bill_select_tag(records,options={},options_html={})
    # return if bill_type_id.blank?
    select options.delete(:object), options.delete(:method), records.map{|record|[record.name,record.id]},
      {:include_blank => true,}.merge(options), {:class => "chosen btn #{options_html.delete(:class)}",
       :style => "width:100%;"}.merge(options_html)
  end

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
    Settings.bill_types.each{ |key, value|
      html << link_to(("添加" + Settings.bill_types_zh[value] + render_new_icon).html_safe,'',
                  class:'btn btn-info pull-right new-bill',data: {toggle:'modal',target: "##{key}-form"})
    }
    html.html_safe    
  end

end
