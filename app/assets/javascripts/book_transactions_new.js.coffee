$ ->
  $("#buyitems th a, #buyitems .pagination a").live "click", ->
    $.getScript @href
    false