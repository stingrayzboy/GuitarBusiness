class GuitarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guitar, only: [:show, :edit, :update, :destroy]
  access all:[:index] , owner: :all
  # GET /guitars
  # GET /guitars.json
  def index
    @guitars = Guitar.all
  end

  # GET /guitars/1
  # GET /guitars/1.json
  def show
    #@guitar_images = @guitar.images.all
    #byebug
  end
  def count_update
    Guitar.find(params[:guitar][:id]).update(accessory_count:params[:guitar][:accessory_count])
  end
  # GET /guitars/new
  def new
    @guitar = Guitar.new
    @guitar_images = @guitar.images.build
  end

  # GET /guitars/1/edit
  def edit
  end

  # POST /guitars
  # POST /guitars.json
  def create
    begin
    @guitar = Guitar.new(guitar_params)

    respond_to do |format|
      if @guitar.save

        params[:images]['location'].each do |a|
          @post_attachment = @guitar.images.create!(:location => a,:imageable_id => @guitar.id, :imageable_type => @guitar.class.to_s)
        end


        format.html { redirect_to @guitar, notice: 'Guitar was successfully created.' }
        format.json { render :show, status: :created, location: @guitar }
      else
        format.html { render :new }
        format.json { render json: @guitar.errors, status: :unprocessable_entity }
      end
    end
    rescue
      @guitar.destroy!
      redirect_to guitars_path, notice: 'Guitar couldnot be created as you uploaded a jpeg instead of jpg'
    end
  end

  # PATCH/PUT /guitars/1
  # PATCH/PUT /guitars/1.json
  def update
    
      if @guitar.update(guitar_params)
        #logger.info "Faraz Noor#{params[:images]}"
        #byebug
        params[:images]['location'].each_with_index do |a,idx|
          unless @guitar.images[idx].nil?
            @post_attachment = @guitar.images[idx].update(:location => a)  
          else
            @post_attachment = @guitar.images.create!(:location => a,:imageable_id => @guitar.id, :imageable_type => @guitar.class.to_s)
          end
          
        end
        respond_to do |format|
          format.html { redirect_to @guitar, notice: 'Guitar was successfully updated.' }
          format.json { render :show, status: :ok, location: @guitar }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @guitar.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /guitars/1
  # DELETE /guitars/1.json
  def destroy
    
    begin
    @guitar.destroy
    respond_to do |format|
      format.html { redirect_to guitars_url, notice: 'Guitar was successfully destroyed.' }
      format.json { head :no_content }
    end
    rescue
      respond_to do |format|
        format.html { redirect_to guitars_url, notice: 'You Cannot Destroy a Guitar that is Sold' }
        format.json { head :no_content }
      end
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guitar
      @guitar = Guitar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guitar_params
      params.require(:guitar).permit(:model, :brand, :price, :serial, :guitar_type,:accessory_count,images_attributes: 
  [:id, :imageable_id,:imageable_type, :location])
    end
end
