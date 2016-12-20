class BookTransaction < ActiveRecord::Base
  belongs_to :campus
  belongs_to :book

  #CONDITION_TYPE = ["All", "Used", "New"]

  validates :sell_book_item_id, :book_id, :seller_user_id, :buyer_user_id, :campus_id, :price, :condition, :peertag, presence: true

  def self.search(search, campus, limit)

    limit_number = 5

    if (search && !search.empty?)
      search = Book.clean_search(search)
      ################################################ Validations ##################################################

      # Check if the book condition parameter is valid. If not return nil.
      #unless CONDITION_TYPE.include?(condition)
      #  return nil
      #end
      
      ################################################# Search Filters ##############################################

      sql_where_condition_items = [] # Will hold each part of the sql string that goes into the where function of the search query.
      sql_where_condition_parameters = [] # Will hold each parameter that will bind to the sql query.


      # Look for sell book items that are being sold at the current users campus
      sql_where_condition_items << "(sell_book_items.campus_id = ?)"
      sql_where_condition_parameters << campus
      
      # Search based on isbn10 or isbn13
      if Book.is_search_isbn?(search)  # If search is isbn
        sql_where_condition_items << "(books.isbn10 LIKE ? OR books.isbn13 LIKE ?)"
        sql_where_condition_parameters << "%#{search}%"
        sql_where_condition_parameters << "%#{search}%"
      else  # If search is title
        sql_where_condition_items << "(books.title LIKE ?)"
        sql_where_condition_parameters << "%#{search}%"
      end

      # Book Condition Filter
      #if ["Used", "New"].include?(condition)
      #  sql_where_condition_items << "(sell_book_items.condition = ?)"
      #  sql_where_condition_parameters << condition
      #end

      ################################################# Build Where Clause ##############################################
      sql_where_condition_query_string = sql_where_condition_items.join(" AND ")
      sql_where = sql_where_condition_parameters.unshift(sql_where_condition_query_string) # Array of query and bind variables necessary for where clause.
      
      # Execute the query.
      # Limit the number of books if needed
      if limit
        books = SellBookItem.joins(:book).where(sql_where).group("books.id").includes(:book).limit(limit_number)
      else
        books = SellBookItem.joins(:book).where(sql_where).group("books.id").includes(:book).all  # "all" is being called at the end to prevent lazy loading
      end


      # If search is isbn, and if book doesn't exist in Book table, then call the Advanced Search to get book information.
      if books[0].nil?  # If book is not being sold.
        if /^(\d{10}|\d{13}|\d{9}X)$/i === search # If search is isbn.
          book_in_books_table = Book.where("isbn10 = ? OR isbn13 = ?", search, search)
          if book_in_books_table.empty?
            Book.advancedSearch(search)
          end
        end
      end
      
    else  # If Search is empty, find most wanted books.
      books = Book.joins(:most_wanted_books, :sell_book_items).where(["most_wanted_books.updated_at > ? AND most_wanted_books.campus_id = ? AND sell_book_items.campus_id = ? ", DateTime.now.months_ago(5), campus, campus]).group("sell_book_items.book_id").order("most_wanted_books.want DESC").limit(limit_number)
      book_ids = books.collect {|book| book.id}
      books = SellBookItem.where(["campus_id = ? AND book_id IN (?)", campus, book_ids]).group("book_id").includes(:book).limit(5)

      books = book_ids.collect {|id| books.detect {|x| x.book_id == id}}  # Sort the books based on want.

      if books.size < limit_number
        books += SellBookItem.where(["campus_id = ? AND book_id NOT IN (?)", campus, book_ids]).group("book_id").includes(:book).limit(limit_number - books.size)
      end
    end

    return books
  end
end
