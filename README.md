# CampusPeer
An online social networking application that allows college students to buy and sell used books. <br><br>
<img src="https://github.com/cramaechi/campus-peer.com/blob/master/img/welcome_page.png" width="650" height="407">

## What state is the project in right now?
The project is currently in the *early stages* of development, with some functionality already implemented for buying and selling books.

## Requirements
  * **[Ruby v. 2.3.0] (https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released/)**
  * **[Ruby on Rails v. 5.0.0.1] (https://rubygems.org/gems/rails/versions/5.0.0.1)**
  * **SQLite 3**
  
## Instructions
**How can I run this project?**

1. Open your terminal and clone the repository:
   ```
   $ git clone https://github.com/cramaechi/campus-peer.git
   ```
   or [download as ZIP] (https://github.com/cramaechi/campus-peer/archive/master.zip).
  
2. Navigate to the project's directory:
   ```
   $ cd campus-peer
   ```
   
3. Ensure you are using the correct versions of Ruby, Rails, and SQLite:
   ```
   $ rake about
   ```
   
4. Start the web server to run the application:
   ```
   $ rails server webrick
   ```
   
5. Finally, access the application by pointing your browser at the URL **http://localhost:3000**.

## Usage
* Login with the following credentials:

  Email: **guest@gmail.com**</br>
  Password: **test**
  
* From the homepage, click on the "Buy" link on the top-left to buy a book:<br><br>
<img src="https://github.com/cramaechi/campus-peer.com/blob/master/img/home_page.png" width="650" height="407">
<br><br>

* Select any of the books in the rectangular box or search for a book by ISBN or name:<br><br>
<img src="https://github.com/cramaechi/campus-peer.com/blob/master/img/book_transactions_page.png" width="650" height="407">
<br><br>

* Buy any of the books listed in the table:<br><br>
<img src="https://github.com/cramaechi/campus-peer.com/blob/master/img/book_summary_page.png" width="650" height="407">
<br><br>

* Your **receipt** is shown for the purchase just made:<br><br>
<img src="https://github.com/cramaechi/campus-peer.com/blob/master/img/receipt_page.png" width="650" height="407">
<br><br>

* You can logout at anytime by clicking the **key icon** at the top-right of the page (shown in above image).
