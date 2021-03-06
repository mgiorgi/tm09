class ReferenceMaterialsController < ApplicationController
  layout 'enter'
  before_filter { |controller| controller.login_required unless (controller.params[:action] == 'show' and controller.params[:public] == 'true') }
  before_filter :set_reference_material, :only => [:show]
  #before_filter :check_access, :only => [:nivel1, :nivel2]
  #require_role "nivel1", :for_all_except => [:index, :show]
  #require_role "nivel2", :for => [:nivel1]
  #require_role "nivel2", :for => [:nivel2]

  def index
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name <> ?', Category::PUBLIC_CATEGORY])
    render :partial => 'reference_materials', :layout => 'enter'
  end

  def show
    send_file(@reference_material.filename, :url_based_filename => true, :filename => File.basename(@reference_material.filename))
  end

  def teorico
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name = ?', Category::TEORICO_CATEGORY])
    render :partial => 'reference_materials', :layout => 'enter'
  end

  def practico
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name = ?', Category::PRACTICO_CATEGORY])
    render :partial => 'reference_materials', :layout => 'enter'
  end

  private
  def set_reference_material
    @reference_material = ReferenceMaterial.find(params[:id] || params[:reference_material_id])
  end
  def check_access  
    #render(:partial => 'shared/not_allowed', :locals => { :protected_resource => action_name }, :layout => 'enter') unless current_user.has_role?(action_name)
  end
end
