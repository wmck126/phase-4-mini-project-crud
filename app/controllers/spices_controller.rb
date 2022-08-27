class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  #GET spices
  def index
    spices = Spice.all
    render json: spices
  end

  #GET spices/:id
  def show
    spices = find_spice
    render json: spices
  end

  #POST /spices
  def create
    spice = Spice.create(title: params[:title], image: params[:image], description: params[:description], notes: params[:notes], rating: params[:rating])
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end



  private
      def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
      end

      def find_spice
        spice = Spice.find_by(id: params[:id])
      end

      def render_not_found
        render json: {error: "Spice not found"}, status: :not_found
      end
end
