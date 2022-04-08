class MoviesController < ApplicationController
  def search
    if params[:query].present?
      @results = Movie.search_by_title_and_overview(params[:query])
    else
      @results = []
    end
  end
end
