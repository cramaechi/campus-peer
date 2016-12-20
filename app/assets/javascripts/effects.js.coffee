window.flyInBooks = ->  
  bookcovers = $(".book-cover")
  imgPosition = new Array()
  imgWidth = bookcovers.first().width()
  imgHeight = bookcovers.first().height()
  
  # Get Book Cover Positions
  bookcovers.each (j) ->
    imgPosition.push($(this).position())
    
  bookcovers.each (i) ->
    $this = $(this)  
    
    # Get Scattered Books Info
    scatteredBooks = $("#scattered-books")
    scatteredBooksOffset = scatteredBooks.offset()
    scatteredBooksCenterLeft = (scatteredBooks.width()/2) + scatteredBooksOffset.left
    scatteredBooksCenterTop = (scatteredBooks.height()/2) + scatteredBooksOffset.top
    
    $this.css
      width: 0
      height: 0
      position: "absolute"
      top: scatteredBooksCenterTop
      left: scatteredBooksCenterLeft
      "z-index": 1
      visibility: "visible"
      opacity: 0.5
    
    $this.delay(i*100).animate
      opacity: 1
      left: imgPosition[i].left
      top: imgPosition[i].top
      width: imgWidth
      height: imgHeight 
    , 300, ->
      $this.css
        position: "static"

window.fadeBooks = ->
  $(".book-container").each (i) ->
    $(this).delay(i * 100).fadeIn(500)
