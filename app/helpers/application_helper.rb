# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  MENU_BACKGROUND = {
    :home => '#FDF1EC',
    :groups => '#FFFDE4',
    :reference_materials => '#EEF5FD',
    :about_us => '#E2ECCB',
    :contact_us => '#E2ECCB'
  }
  def google_analytics
    render :partial => 'shared/google_analytics'
  end
end
