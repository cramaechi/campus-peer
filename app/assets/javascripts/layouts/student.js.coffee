$ ->
  initNavBar()
  initNavbarQtips()

window.initNavBar = ->
  stickerTop = parseInt($("#content-left").offset().top)
  $(window).scroll ->
    $("#content-left").css (if (parseInt($(window).scrollTop()) + parseInt($("#content-left").css("margin-top")) > stickerTop)
      position: "fixed"
      top: "0px"
     else position: "relative")


window.initNavbarQtips = ->
  text = ["Search for a book that you want to buy", 
          "Post a book that you would like to sell", 
          "Create a study group for a course", 
          "Join a study group for a course", 
          "Find a tutor for a course", 
          "Sign up to be a tutor"]

  $.each $(".subnav li"), (index, value) ->
    $(this).qtip
      content:
        text: text[index]
      position:
        corner:
          target: "rightMiddle"
          tooltip: "leftMiddle"
      style:        
        tip:  "leftMiddle"
        width:
          max: 400
        border:
          width: 1
          radius: 4
        'font-size': 12
        name: "green"
        