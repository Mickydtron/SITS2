class ShipsController < ApplicationController
  before_action :set_ship, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /ships
  # GET /ships.json
  def index
    # @ships = Ship.all
    @ships = current_user.ships unless current_user.nil?
    respond_with(@ships)
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
  end

  # GET /ships/new
  def new
    @ship = Ship.new
  end

  # GET /ships/1/edit
  def edit
  end

  # POST /ships
  # POST /ships.json
  def create
    @ship = current_user.ships.new(ship_params)
    respond_to do |format|
      if @ship.save
        format.html { redirect_to @ship, notice: 'Ship was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ship }
      else
        format.html { render action: 'new' }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
      end
  end

  # PATCH/PUT /ships/1
  # PATCH/PUT /ships/1.json
  def update
    respond_to do |format|
      if @ship.update(ship_params)
        format.html { redirect_to @ship, notice: 'Ship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  # GET /ships/detail/1
  # GET /ships/detail/1.json
  def detail
    set_ship 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = Ship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_params
      params.require(:ship).permit(:name, :ship_class, :pivot, :roll, :notes, :user_id, :startFront, :startTop, :midFront, :midTop, :endFront, :endTop)
    end
end
