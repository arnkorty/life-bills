module BillsHelper
  def render_bill_multiple_select_tag(records,options={})
    return if bill_type_id.blank?
    select options[:object], options[:method], records.map{|item|[item.name,item.id]},
      {:include_blank => true}, :class => 'chosen', :style => "width:100%;", :multiple => true
  end
end
