# Once the page fully loads
$(window).bind "load", ->
  toggleLoading() # Get rid of the loading spinner
  flyInBooks()

# Document Ready (DOM)
$ ->
  initLoading()
  initBooksQtips()
  initBookSearchSubmit()  

initLoading = ->
  booksArea = $("#books-area")
  booksAreaOffset = booksArea.offset()
  booksAreaCenterLeft = (booksArea.width()/2) + booksAreaOffset.left - 50
  booksAreaCenterTop = (booksArea.height()/2) + booksAreaOffset.top - 35
  loading = $("#loading")
  $("#loading").css
    position: "absolute"
    top: booksAreaCenterTop
    left: booksAreaCenterLeft
    "z-index": 1

window.toggleLoading = ->
  initLoading() # Need to do this again to make sure the positioning is right.
  $("#loading").toggle()

# Handles the ajax search request.
initBookSearchSubmit = ->
  $("#books-search").submit ->
    bookcovers = $(".book-cover")
    bookcovers.toggle()
    bookcovers.qtip("destroy") # Kill Qtip
    $("#noresults").hide()
    toggleLoading()
    $.get @action, $(this).serialize(), null, "script"
    false

window.toggleNoResults = ->
  $("#noresults").toggle() if window.books.length == 0

window.initBooksQtips = ->
  $.each $(".book-cover"), (index, value) ->
    $(this).qtip
      content:
        text: "<b>TITLE:</b> " + window.books[index].title + "<br \>" + 
            "<b>AUTHOR:</b> " + window.books[index].author + "<br \>" +
            "<b>ISBN10:</b> " + window.books[index].isbn10 + "<br \>" +
            "<b>ISBN13:</b> " + window.books[index].isbn13 + "<br \>"
      position:
        corner:
          target: "bottomMiddle"
          tooltip: "topMiddle"
      style:        
        tip:  "topMiddle"
        width:
          max: 400
        border:
          width: 1
          radius: 4
        'font-size': 12
        name: "dark"
