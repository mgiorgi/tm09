module Admin::ArticlesHelper
  #description field is shown in FCK editor format
  def content_form_column(record, input_name)
    fckeditor_textarea( :record, :content, :toolbarSet => 'Default', :name => input_name, :width => "800px", :height => "400px" )
    #text_area :record, :content
  end
  #description text is displayed in rich format
  def content_column(record)
    sanitize(record.content)
  end
end
