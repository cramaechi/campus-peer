class MostWantedBook < ActiveRecord::Base
  belongs_to :campus
  belongs_to :book

  def self.update_most_wanted(book, campus)
  	wantedBook = MostWantedBook.where(["book_id = ? AND campus_id = ?", book, campus]).first

  	if wantedBook
  	  wantedBook.want += 1
  	  wantedBook.save
  	else
  	  MostWantedBook.create(:book_id => book, :campus_id => campus, :want => 1)
  	end
  end

  # Get a specific ammount of most wanted books within the last 5 months for a specific campus.
  def self.get_most_wanted(ammount, campus)
  	books = Book.joins(:most_wanted_books).where(["most_wanted_books.updated_at > ? AND most_wanted_books.campus_id = ?", DateTime.now.months_ago(5), campus]).order("most_wanted_books.want DESC").limit(ammount)
  	if !books.empty?
  		if books.size < ammount
        book_ids = books.collect { |book| book.id}
	  	  books += Book.where(["id NOT IN (?)", book_ids]).limit(ammount - books.size)
	  	end
  	else
  	  books = Book.limit(ammount)
  	end
    books
  end

  # Search through the most wanted books within the last 5 months for a specific campus.
  def self.search_most_wanted(search, campus)
    if (search && !search.empty?)
      if /^\d+X{0,1}$/u === search
        books = Book.joins(:most_wanted_books).where(["most_wanted_books.updated_at > ? AND (books.isbn10 LIKE ? OR books.isbn13 LIKE ?) AND most_wanted_books.campus_id = ?", DateTime.now.months_ago(5), "%#{search}%", "%#{search}%", campus]).order("most_wanted_books.want DESC")
        if ((search.length == 10 or search.length == 13) and books[0].nil?)
          Book.advancedSearch(search)
        end
      else
        books = Book.joins(:most_wanted_books).where(["most_wanted_books.updated_at > ? AND books.title LIKE ? AND most_wanted_books.campus_id = ?", DateTime.now.months_ago(5), "%#{search}%", campus]).order("most_wanted_books.want DESC")
      end
    else
      books = Book.joins(:most_wanted_books).where(["most_wanted_books.updated_at > ? AND most_wanted_books.campus_id = ?", DateTime.now.months_ago(5), campus]).order("most_wanted_books.want DESC")
    end
    books
  end

end
