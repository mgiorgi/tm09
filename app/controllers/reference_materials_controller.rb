class ReferenceMaterialsController < ApplicationController
  layout 'enter'
  before_filter :login_required
  before_filter :set_reference_material, :only => [:show]

  def index
    @reference_materials = ReferenceMaterial.all
  end

  def show
    send_file(@reference_material.filename, :url_based_filename => true, :filename => File.basename(@reference_material.filename))
  end

  private
  def set_reference_material
    @reference_material = ReferenceMaterial.find(params[:id] || params[:reference_material_id])
  end
end
