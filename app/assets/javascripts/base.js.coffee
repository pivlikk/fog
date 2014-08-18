ready = ->
  $("#testjson").click ->
    $.get("http://maps.googleapis.com/maps/api/geocode/json",
      address: "гаг"
      sensor: false
      language: 'ru'
      components: 'country:ru|administrative_area:Sankt-Petersburg'
    ).done (data) ->
      console.log data
      return
  
  $("#inputWarning").typeahead
    limit: 1000
    delay: 1500
    source: (query, process) ->
      $.get "http://maps.googleapis.com/maps/api/geocode/json",
        address: query
        sensor: false
        language: 'ru'
        components: 'country:ru|administrative_area:Sankt-Petersburg'
      , (data) ->
        #console.log data
        resultList = data.results.map((item) ->
          (item.address_components[1].long_name+" "+item.address_components[0].long_name).toString()
        )
        console.log resultList
        process resultList
      
 

$(document).ready(ready)
$(document).on('page:load', ready)