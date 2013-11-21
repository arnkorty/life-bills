class StringInput < SimpleForm::Inputs::StringInput
  def input    
    @input_html_classes.push 'form-control'     
    template.content_tag(:div, @input_html_options[:div_html] || {class: 'col-sm-10 input-group'}) do       
      super
    end
  end  
end