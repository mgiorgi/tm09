class HomeController < ApplicationController
  layout 'enter'
  def public_reference_materials
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name = ?', Category::PUBLIC_CATEGORY])
  end
end
