#= require select2
#= require_self
$ ->
  distincts = $('#candidate_distinct_id').html()
  
  $('#candidate_municipality_id').change ->
    mu = $('#candidate_municipality_id :selected').text()
    options = $(distincts).filter("optgroup[label='#{mu}']").html()
    if options
      
      $('#candidate_distinct_id').html("<option>Выбор округа</option>"+options)
    else
      $('#candidate_distinct_id').empty()