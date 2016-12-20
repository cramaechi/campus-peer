$ ->
  $("#search-items th a, #search-items .pagination a").live "click", ->
    $.getScript @href
    false
  $("#search-form2").submit ->
    $.get @action, $(this).serialize(), null, "script"
    false
