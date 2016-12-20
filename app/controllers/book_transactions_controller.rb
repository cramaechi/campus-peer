class BookTransactionsController < ApplicationController

  helper_method :sort_column, :sort_direction

  # GET /book_transactions
  # GET /book_transactions.json
  def index
    @books_to_buy = BookTransaction.search(params[:search], current_user.campus_id, true)
    @books = @books_to_buy.collect { |book| book.book }

    if @books_to_buy
      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.json { render json: @books_to_buy }
      end
    else
      redirect_to book_transactions_path
    end
  end

  def search
    #@books_to_buy = BookTransaction.search(params[:search], current_user.campus_id, false).page(params[:page]).per(1)
    @books_to_buy = Kaminari.paginate_array(BookTransaction.search(params[:search], current_user.campus_id, false)).page(params[:page]).per(1)

    # Kaminari.paginate_array(my_array_object).page(params[:page]).per(10)

    if @books_to_buy
      respond_to do |format|
        format.html # search.html.erb
        format.js
        format.json { render json: @books_to_buy }
      end
    else
      redirect_to search_book_transactions_path
    end
  end

  # GET /book_transactions/1
  # GET /book_transactions/1.json
  def show
    begin
      @book_transaction = BookTransaction.find(params[:id])
      @seller = User.find(@book_transaction.seller_user_id)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @book_transaction }
      end
    rescue Exception => e
      redirect_to book_transactions_path
    end
  end

  # GET /book_transactions/new
  # GET /book_transactions/new.json
  def new
    @sell_book_items = SellBookItem.joins(:book).where(["sell_book_items.campus_id = ? AND books.isbn13 LIKE ?", current_user.campus_id, params[:buy_book]]).includes(:user, :book).order(sort_column + " " + sort_direction).page(params[:page]).per(2)
    
    unless @sell_book_items.empty?
      unless session["buy_book_new_#{@sell_book_items.first.book.id}"]  # Most wanted should only be updated on unique requests.
        MostWantedBook.update_most_wanted(@sell_book_items.first.book.id, current_user.campus_id)
        session["buy_book_new_#{@sell_book_items.first.book.id}"] = true
      end
      
      respond_to do |format|
        format.html # new.html.erb
        format.js
        format.json { render json: @sell_book_items }
      end
    else
      redirect_to book_transactions_path
    end
  end

  # POST /book_transactions
  # POST /book_transactions.json
  def create 
    sell_book_item = SellBookItem.find(params[:buy_book])
    @book_transaction = BookTransaction.new(:sell_book_item_id => sell_book_item.id,
                                            :book_id => sell_book_item.book_id,
                                            :seller_user_id => sell_book_item.user_id,
                                            :buyer_user_id => current_user.id,
                                            :campus_id => sell_book_item.campus_id,
                                            :price => sell_book_item.price,
                                            :condition => sell_book_item.condition,
                                            :condition_description => sell_book_item.condition_description)
    
    @book_transaction.peertag = generate_peertag

    respond_to do |format|
      if @book_transaction.save
        SellBookItem.delete(@book_transaction.sell_book_item_id)  # Delete the book from sell_book_items table.        
        format.html { redirect_to @book_transaction, notice: 'Book transaction was successfully created.' }
        format.json { render json: @book_transaction, status: :created, location: @book_transaction }

        # Send email to both buyer and seller.

      else
        format.html { render action: "new" }
        format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def sort_column
      %w[price condition].include?(params[:sort]) ? params[:sort] : "price"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

=begin
  # GET /book_transactions/1/edit
  def edit
    @book_transaction = BookTransaction.find(params[:id])
  end
=end

=begin
  # PUT /book_transactions/1
  # PUT /book_transactions/1.json
  def update
    @book_transaction = BookTransaction.find(params[:id])

    respond_to do |format|
      if @book_transaction.update_attributes(params[:book_transaction])
        format.html { redirect_to @book_transaction, notice: 'Book transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book_transaction.errors, status: :unprocessable_entity }
      end
    end
  end
=end

=begin
  # DELETE /book_transactions/1
  # DELETE /book_transactions/1.json
  def destroy
    @book_transaction = BookTransaction.find(params[:id])
    @book_transaction.destroy

    respond_to do |format|
      format.html { redirect_to book_transactions_url }
      format.json { head :no_content }
    end
  end
=end

end
