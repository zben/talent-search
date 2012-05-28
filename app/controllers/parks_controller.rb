class ParksController < ApplicationController
  # GET /parks
  # GET /parks.json
  def index
    @parks = Park.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parks }
    end
  end

  # GET /parks/1
  # GET /parks/1.json
  def show
    @park = Park.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @park }
    end
  end

  # GET /parks/new
  # GET /parks/new.json
  def new
    @park = Park.new
    @park.photos.build
    @park.downloads.build
  end

  # GET /parks/1/edit
  def edit
    @park = Park.find(params[:id])
    @park.photos.build if @park.photos.empty?
    @park.downloads.build if @park.downloads.empty?
  end

  # POST /parks
  # POST /parks.json
  def create
    @park = Park.new(params[:park])

    if @park.save
      redirect_to @park
    else
      @park.photos.build if @park.photos.empty?
      @park.downloads.build if @park.downloads.empty?
      render :new
    end
  end

  # PUT /parks/1
  # PUT /parks/1.json
  def update
    @park = Park.find(params[:id])
    if @park.update_attributes(params[:park])
      @park.logo = nil if params[:_destroy_logo]
      @park.save
      redirect_to @park
    else
      render :edit
    end
  end

  # DELETE /parks/1
  # DELETE /parks/1.json
  def destroy
    @park = Park.find(params[:id])
    @park.destroy

    respond_to do |format|
      format.html { redirect_to parks_url }
      format.json { head :ok }
    end
  end
end
