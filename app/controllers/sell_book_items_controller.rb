class SellBookItemsController < ApplicationController
  # GET /sell_book_items
  # GET /sell_book_items.json
  def index
    @books = SellBookItem.search(params[:search], current_user.campus_id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
      format.js
    end
  end

  # GET /sell_book_items/1
  # GET /sell_book_items/1.json
  def show
    begin
      @sell_book_item = SellBookItem.find(params[:id])
      @book_to_be_sold = @sell_book_item.book

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @sell_book_item }
      end
    rescue Exception => e
      redirect_to sell_book_items_path
    end
    
  end

  # GET /sell_book_items/new
  # GET /sell_book_items/new.json
  def new
    @sell_book_item = SellBookItem.new(:user_id => current_user.id, :book_id => params[:book], :campus_id => current_user.campus_id)
    
    begin
      @book_to_be_sold = Book.find(params[:book])

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @sell_book_item }
      end
    rescue Exception => e
      redirect_to sell_book_items_path
    end
  end

  # GET /sell_book_items/1/edit
  def edit
    @sell_book_item = SellBookItem.find(params[:id])
    @book_to_be_sold = @sell_book_item.book
  end

  # POST /sell_book_items
  # POST /sell_book_items.json
  def create
    @sell_book_item = SellBookItem.new(select_book_item_params)

    respond_to do |format|
      if @sell_book_item.save
        format.html { redirect_to sell_book_item_path(@sell_book_item), notice: 'Sell book item was successfully created.' }
        format.json { render json: @sell_book_item, status: :created, location: @sell_book_item }
      else
        @book_to_be_sold = @sell_book_item.book
        format.html { render action: "new" }
        format.json { render json: @sell_book_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sell_book_items/1
  # PUT /sell_book_items/1.json
  def update
    @sell_book_item = SellBookItem.find(params[:id])

    respond_to do |format|
      if @sell_book_item.update_attributes(params[:sell_book_item])
        format.html { redirect_to @sell_book_item, notice: 'Sell book item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sell_book_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sell_book_items/1
  # DELETE /sell_book_items/1.json
  def destroy
    @sell_book_item = SellBookItem.find(params[:id])
    @sell_book_item.destroy

    respond_to do |format|
      format.html { redirect_to sell_book_items_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def select_book_item_params
      params.require(:sell_book_item).permit(:user_id, :book_id, :campus_id, :price, :condition, :condition_description)
  end
end
