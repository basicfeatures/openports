class PortsController < ApplicationController
  before_action :set_port, only: %i[ show edit update destroy ]

  # GET /ports or /ports.json
  def index
    @ports = Port.all
  end

  # GET /ports/1 or /ports/1.json
  def show
  end

  # GET /ports/new
  def new
    @port = Port.new
  end

  # GET /ports/1/edit
  def edit
  end

  # POST /ports or /ports.json
  def create
    @port = Port.new(port_params)

    respond_to do |format|
      if @port.save
        format.html { redirect_to port_url(@port), notice: "Port was successfully created." }
        format.json { render :show, status: :created, location: @port }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ports/1 or /ports/1.json
  def update
    respond_to do |format|
      if @port.update(port_params)
        format.html { redirect_to port_url(@port), notice: "Port was successfully updated." }
        format.json { render :show, status: :ok, location: @port }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ports/1 or /ports/1.json
  def destroy
    @port.destroy

    respond_to do |format|
      format.html { redirect_to ports_url, notice: "Port was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_port
      @port = Port.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def port_params
      params.require(:port).permit(:name, :description, :summary, :url, :category_id)
    end
end
