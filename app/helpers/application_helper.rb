# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_analytics
    render :partial => 'shared/google_analytics'
  end
end
