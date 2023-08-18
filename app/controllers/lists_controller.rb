class ListsController < ApplicationController
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @movies = Movie.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:list , partial: "lists/list_card", locals: { list: @list })
        end

        format.html { redirect_to lists_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
