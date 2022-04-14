class ListsController < ApplicationController
  def index
    # @homepage = true
    @lists = List.all
  end

  def show
    # @listshowpage = true
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list), notice: 'List successfully created.'
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
