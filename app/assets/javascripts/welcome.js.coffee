$ ->
  initCampusAutoComplete()

  $("#myslideshow").bjqs
      width: 500
      height: 270
      animation: "slide"
      showMarkers: true
      showControls: true
      centerMarkers: true
      centerControls: false
      nextText: "<img src=\"/assets/WelcomePage/rightarrow.png\">"
      prevText: "<img src=\"/assets/WelcomePage/leftarrow.png\">"
      
  $("#target").fold 
      side: "right"
      directory: "/assets/WelcomePage"
      turnImage: "fold-sw.png"

  $("#pic1").fadeIn 3000
  $("#pic8").fadeIn 9000
  $("#pic5").fadeIn 17000
  $("#pic6").fadeIn 28000
  $("#pic7").fadeIn 37000


initCampusAutoComplete = ->
  $("#campus_textfield").autocomplete
    source: "/ajax/campus"
    delay: 0