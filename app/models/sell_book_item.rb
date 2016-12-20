class SellBookItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  belongs_to :campus

  CONDITION_TYPE = ["Used", "New"]

  validates :user_id, :book_id, :campus_id, :price, :condition, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01, less_than_or_equal_to: 2000 }
  validates :price, format: { with: %r{^\d*.{1}\d{0,2}0*$}i, multiline: true, message: 'must be in a valid format (d.dd)' }
  validates :condition_description, length: { maximum: 255 }
  validates :condition, inclusion: { in: CONDITION_TYPE, message: 'must be a valid condition' }


  def self.search(search, campus)
    limit_number = 5
  	if (search && !search.empty?)
      search = Book.clean_search(search)
      if Book.is_search_isbn?(search)
        books = Book.where("isbn10 LIKE ? OR isbn13 LIKE ?", "%#{search}%", "%#{search}%").limit(limit_number)
        if (books.empty? && (Book.valid_isbn13?(search) || Book.valid_isbn10?(search))) 
          Book.advancedSearch(search)
          books = Book.where("isbn10 LIKE ? OR isbn13 LIKE ?", "%#{search}%", "%#{search}%").limit(limit_number)  # Re-run the query since the advanced search might have returned something.
        end
      else
        books = Book.where("title LIKE ?", "%#{search}%").limit(limit_number)
      end
  	else
      books = MostWantedBook.get_most_wanted(limit_number, campus)
  	end
    books
  end

end
