class GroupPicturesController < ApplicationController
  layout 'enter'
  # GET /group_pictures
  # GET /group_pictures.xml
  def index
    @group_pictures = GroupPicture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_pictures }
    end
  end

  # GET /group_pictures/1
  # GET /group_pictures/1.xml
  def show
    @group_picture = GroupPicture.find(params[:id])
    render :action => 'show', :layout => false
  end

  # GET /group_pictures/new
  # GET /group_pictures/new.xml
  def new
    @group_picture = GroupPicture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_picture }
    end
  end

  # GET /group_pictures/1/edit
  def edit
    @group_picture = GroupPicture.find(params[:id])
  end

  # POST /group_pictures
  # POST /group_pictures.xml
  def create
    @group_picture = GroupPicture.new(params[:group_picture])

    respond_to do |format|
      if @group_picture.save
        flash[:notice] = 'GroupPicture was successfully created.'
        format.html { redirect_to(@group_picture) }
        format.xml  { render :xml => @group_picture, :status => :created, :location => @group_picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_pictures/1
  # PUT /group_pictures/1.xml
  def update
    @group_picture = GroupPicture.find(params[:id])

    respond_to do |format|
      if @group_picture.update_attributes(params[:group_picture])
        flash[:notice] = 'GroupPicture was successfully updated.'
        format.html { redirect_to(@group_picture) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_pictures/1
  # DELETE /group_pictures/1.xml
  def destroy
    @group_picture = GroupPicture.find(params[:id])
    @group_picture.destroy

    respond_to do |format|
      format.html { redirect_to(group_pictures_url) }
      format.xml  { head :ok }
    end
  end
end
