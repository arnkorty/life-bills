class PasswordInput < SimpleForm::Inputs::PasswordInput
  def input    
     @input_html_classes.push 'form-control'
     # label_html_options[:class].push 'col-sm2'  
     # @label_html_classes.push 'fsdhfsodhfisfhsiohf'
    template.content_tag(:div, @input_html_options[:div_html] || {class: 'col-sm-10 input-group'}) do       
      super
    end
  end  

  # def label
  #   Rails.logger.warn '*' * 3132
  #   Rails.logger.warn instance_variables
  #   Rails.logger.warn label_html_options
  #   Rails.logger.warn label_html_options[:class]
  #   ''
  # end
  # def label_html_options
  #   super[:class].push 'col-sm2'
  #   super
  # end
end