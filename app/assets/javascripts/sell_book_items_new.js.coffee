$ ->
  $("#drop-down").change ->
    x = document.getElementById("drop-down").selectedIndex
    if x is 0
      document.getElementById("condition-type").innerHTML = "Used"
    else
      document.getElementById("condition-type").innerHTML = "New"
