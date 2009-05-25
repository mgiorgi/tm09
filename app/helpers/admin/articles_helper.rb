module Admin::ArticlesHelper
  #description field is shown in FCK editor format
  def body_form_column(record, input_name)
    fckeditor_textarea( :record, :body, :toolbarSet => 'Default', :name => input_name, :width => "800px", :height => "400px" )
    #text_area :record, :content
  end
  #description text is displayed in rich format
  def body_column(record)
    sanitize(record.body)
  end
end
