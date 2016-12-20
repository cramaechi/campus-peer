# SeedBook.rb
# This file will load some test data for the Book table.
# This script will will first delete all data from the Books table. It will then read the input file, and add the data into the Books table. 

fileRead = File.new(Dir.pwd + "/script/SeedDB/SeedBook/input.txt", "r")

Book.delete_all

Book.transaction do
  while (line = fileRead.gets)
	begin
	  row = line.scan(/(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\n/).flatten
	  book = Book.create
	  book.title = row[0]
	  book.author = row[1]
	  book.publisher = row[2]
	  book.isbn10 = row[3]
	  book.isbn13 = row[4]
	  book.pricenew = row[5]
	  book.priceused = row[6]
	  book.save
	rescue Exception => e
	  puts "Error Occured: #{e.message}"
	end
  end
end
