class BookTransactionMailer < ActionMailer::Base
  default from: "info@campuspeer.com"

  def book_transaction_instructions_buyer(seller)
  	#mail(:to => user.email, :subject => "Book Transaction Instructions")  	
  end

  def book_transaction_instructions_buyer(buyer)
  	
  end
end
