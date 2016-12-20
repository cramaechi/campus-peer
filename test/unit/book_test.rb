require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "book attributes must not be empty" do
  	book = Book.new

  	assert book.invalid?
  	assert book.errors[:title].include?("can't be blank")
  	assert book.errors[:author].include?("can't be blank")
  	assert book.errors[:isbn10].include?("can't be blank")
  	assert book.errors[:isbn13].include?("can't be blank")
  end

  test "isbn10 and isbn13 must be unique" do
  	book = Book.new(title: "Book title",
  					author: "Arun Chacko",
  					publisher: "Book publisher",
  					isbn10: "0073523372",
  					isbn13: "9780073523378")
  	book.save

  	assert book.errors[:isbn10].include?("has already been taken")
  	assert book.errors[:isbn13].include?("has already been taken")
  end

  test "isbn10 is ten characters in length" do
  	book = Book.new(isbn10: "123456789")
  	book.save 	

  	assert book.errors[:isbn10].include?("is the wrong length (should be 10 characters)")
  end

  test "isbn13 is thirteen characters in length" do
  	book = Book.new(isbn13: "123456789012")
	book.save

  	assert book.errors[:isbn13].include?("is the wrong length (should be 13 characters)")
  end

  test "self.valid_isbn10?" do
    isbn10 = ["030680476X", "0470526998", "053439258X", "142313494X", "9812563466", "0306815613", "1599410206", "0205501788", "082642788X", "0324782063", "0321408969"]
    notIsbn10 = ["9780321408969", "9781422481127", "9780155510050", "9780980232714", "9780201633610", "9780205116713", "9780495599111", "9780073378251", "9780321468932", "9780387982953", "blah", "Testing"]

    isbn10.each do |i|
      assert Book.valid_isbn10?(i)
    end

    notIsbn10.each do |j|
      assert_equal Book.valid_isbn10?(j), false
    end
  end

  test "self.valid_isbn13?" do
    isbn13 = ["9780321408969", "9781422481127", "9780155510050", "9780980232714", "9780201633610", "9780205116713", "9780495599111", "9780073378251", "9780321468932", "9780387982953"]
    notIsbn13 = ["030680476X", "0470526998", "053439258X", "142313494X", "9812563466", "0306815613", "1599410206", "0205501788", "082642788X", "0324782063", "0321408969","blah", "Testing"]
    

    isbn13.each do |i|
      assert Book.valid_isbn13?(i)
    end

    notIsbn13.each do |j|
      assert_equal Book.valid_isbn13?(j), false  
    end
  end

  test "self.clean_search" do
    isbn_search = [" 1-23-456", "  123-456", "12-3-456 ", "123-4-56  ", " 123-45-6 ", "  123456  "]
    title_search = ["testing", " testing", "  testing", "testing ", "testing  ", " testing ", "  testing  "]

    isbn_search.each do |i|
      assert_equal Book.clean_search(i), "123456"
    end

    title_search.each do |j|
      assert_equal Book.clean_search(j), "testing"
    end
  end

  test "self.is_search_isbn?" do
    isbn = ["123456", "030680476X", "0470526998", "9780321408969"]
    notIsbn = ["Hello", "Testing", "123 hello"]

    isbn.each do |i|
      assert Book.is_search_isbn?(i)
    end

    notIsbn.each do |j|
      assert_equal Book.is_search_isbn?(j), false
    end
  end

end
