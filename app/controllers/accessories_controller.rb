class AccessoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_accessory, only: [:show, :edit, :update, :destroy]
  access all:[:show,:index] , owner: :all
  # GET /accessories
  # GET /accessories.json
  def index
    @accessories = Accessory.all
  end

  # GET /accessories/1
  # GET /accessories/1.json
  def show
    @accessory_images = @accessory.images.all
  end

  # GET /accessories/new
  def new
    @accessory = Accessory.new
    @accessory_images = @accessory.images.build
  end

  # GET /accessories/1/edit
  def edit
  end

  # POST /accessories
  # POST /accessories.json
  def create
    @accessory = Accessory.new(accessory_params)

    respond_to do |format|
      if @accessory.save

        params[:images]['location'].each do |a|
          @post_attachment = @accessory.images.create!(:location => a,:imageable_id => @accessory.id, :imageable_type => @accessory.class.to_s)
        end


        format.html { redirect_to @accessory, notice: 'Accessory was successfully created.' }
        format.json { render :show, status: :created, location: @accessory }
      else
        format.html { render :new }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accessories/1
  # PATCH/PUT /accessories/1.json
  def update
    respond_to do |format|
      if @accessory.update(accessory_params)

        params[:images]['location'].each do |a|
          @post_attachment = @accessory.images.update(:location => a)
        end

        format.html { redirect_to @accessory, notice: 'Accessory was successfully updated.' }
        format.json { render :show, status: :ok, location: @accessory }
      else
        format.html { render :edit }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessories/1
  # DELETE /accessories/1.json
  def destroy
    @accessory.destroy
    respond_to do |format|
      format.html { redirect_to accessories_url, notice: 'Accessory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessory
      @accessory = Accessory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accessory_params
      params.require(:accessory).permit(:name, :price, :characteristic,:accessory_count, images_attributes: 
  [:id, :imageable_id,:imageable_type, :location])
    end
end
