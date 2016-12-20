class MostWantedBookController < ApplicationController
  def index
  	@books = MostWantedBook.search_most_wanted(params[:search], current_user.campus_id).page(params[:page]).per(2)

    if @books
      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.json { render json: @books }
      end
    else
      redirect_to sell_book_items_path
    end
  end
end
