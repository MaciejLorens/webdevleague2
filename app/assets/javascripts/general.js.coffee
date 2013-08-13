$ ->
  $("#skill_select").change ->
    division = $(this).val()
    if division == 'All'
      window.location = '/divisions/'
    else
      window.location = '/divisions/' + $(this).val()
