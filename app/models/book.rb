require 'open-uri'
require 'rubygems'
require 'nokogiri'

class Book < ActiveRecord::Base
  has_many :sell_book_items
  has_many :book_transactions
  has_many :most_wanted_books
  
  validates :title, :author, :isbn10, :isbn13, presence: true	# Makes sure these aren't empty.
  validates :isbn10, :isbn13, uniqueness: true	# Makes sure all isbns are unique.
  validates :isbn10, length: { is: 10 }	# Makes sure that isbn10 has a length of 10.
  validates :isbn13, length: { is: 13 }	# Makes sure that isbn13 has a length of 13.

  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/i
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/i


  # This function will find the appropriate book cover for a book. If it can not find one, it will use nilcover.
  def self.cover(isbn13)
  	if File.file?("#{Rails.root}/app/assets/images/BookCovers/#{isbn13}/#{isbn13}.jpg")
      "/assets/BookCovers/#{isbn13}/#{isbn13}.jpg"
  	else
      "/assets/BookCovers/nilcover.jpg"
  	end
  end

  # Will look up book information online when not found in DB.
  # Takes in either isbn10 or isbn13. Nothing happens if it cant find the book.
  def self.advancedSearch(isbn)
    baseUrl = "http://books.google.com/books/feeds/volumes?q=isbn:"
    currentUrl = baseUrl + isbn
    title = ""
    author = ""
    googleId = ""
    isbn10 = ""
    isbn13 = ""
    publisher = ""
    cover = ""

    begin
      doc = Nokogiri::XML(open(currentUrl))

      doc.xpath("//xmlns:entry[1]//dc:*").each do |line|
        if line.name == "title"
          title = title + line.children[0].to_s + ", "
        end
        if line.name == "creator"
          author = author + line.children[0].to_s + ", "
        end
        if line.name == "identifier"
          id = line.children[0].to_s
          if /.*ISBN.*/ === id
            isbn = id.scan(/\d+X{0,1}/u)[0]
            if isbn.length == 10
              isbn10 = isbn
            elsif isbn.length == 13
              isbn13 = isbn
            end
          else
            googleId = id;
          end
        end
        if line.name == "publisher"
          publisher = line.children[0].to_s
        end
      end

      title = title[0..-3] # Get rid of trailing ", "
      author = author[0..-3]  # Get rid of trailing ", "
      cover = "http://bks8.books.google.com/books?id=#{googleId}&printsec=frontcover&img=1&zoom=1"

      # Insert new book into DB.
      new_book = Book.new(title: title, author: author, isbn10: isbn10, isbn13: isbn13, publisher: publisher)
      
      if new_book.save
        # Download cover.
        Dir.mkdir("#{Rails.root}/app/assets/images/BookCovers/#{isbn13}")
        imgWrite = open("#{Rails.root}/app/assets/images/BookCovers/#{isbn13}/#{isbn13}.jpg", "wb")
        imgWrite.write(open(cover).read)
        imgWrite.close
      end
    rescue Exception => e
      logger.error e.message
    end
  end

  # Checks if the isbn is a valid isbn10 or not.
  def self.valid_isbn10?(isbn) #:nodoc:
    if (isbn || '').match(ISBN10_REGEX)
      isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
      check_digit = isbn_values.pop # last digit is check digit
      check_digit = (check_digit == 'X') ? 10 : check_digit.to_i

      sum = 0
      isbn_values.each_with_index do |value, index|
        sum += (index + 1) * value.to_i
      end

      (sum % 11) == check_digit
    else
      false
    end
  end

  # Checks if the isbn is a valid isbn13 or not.
  def self.valid_isbn13?(isbn) #:nodoc:
    if (isbn || '').match(ISBN13_REGEX)
      isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
      check_digit = isbn_values.pop.to_i # last digit is check digit

      sum = 0
      isbn_values.each_with_index do |value, index|
        multiplier = (index % 2 == 0) ? 1 : 3
        sum += multiplier * value.to_i
      end

      result = (10 - (sum % 10))
      result = 0 if result == 10

      result == check_digit
    else
      false
    end
  end

  # This method determines if the search is an ISBN.
  # It allows for partial search of isbn. Ex: (123-56)
  def self.is_search_isbn?(search)
    /^(\d+\-?)+[\d|X]$/i === search
  end

  # Gets rid of leading and trailing white space 
  # ISBN: Gets rid of dashes (-) and white space from search string and capitilizes letters
  def self.clean_search(search)
    search = search.strip
    is_search_isbn?(search) ? search.upcase.gsub(/\ |-/, '') : search
  end

end
