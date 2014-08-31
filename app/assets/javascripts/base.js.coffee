window.Hlp = {}
@Hlp.Load =
  shareLink: ->
    $("#share_url").click ->
      $("#loader").show()
      $.ajax
        type: "get"
        #dataType: 'script'
        url: $("#share_url").data("shareurl")
        success: (data, textStatus, jqXHR) ->
          $("#shareModal").modal('show')
          $(".share").ShareLink
            title: "Мунвыборы-2014"
            text: "<img src='#{data}' />"
            image: data
            url: data
          $("#loader").hide()
          
      
  socialShare: ->
    $(".share").ShareLink
      title: "Мунвыборы-2014"
      text: ""
      image: encodeURIComponent($("#share_url").data("shareurl"))
      url: encodeURIComponent($("#share_url").data("shareurl"))
      
  reloadLinkMore: ->
    $(".about_hint-ico_more").click ->
      $.ajax
        type: "get"
        dataType: 'script'
        url: "/"
        success: (data, textStatus, jqXHR) ->
ready = ->
  
  
  $(".share_main").ShareLink
    title: "Мунвыборы-2014"
    text: "За кого голосовать 14 сентября?  Узнай своих кандидатов на mo2014.ru"
    image: ""
    url: window.location.href
       
  $(".outlook-arrows").click ->
    $("#slide_1").toggleClass("active")
    $("#slide_2").toggleClass("active")
  $(".show_slide_2").click ->
    $("#slide_1").removeClass("active")
    $("#slide_2").addClass("active")

  $(".show_slide_1").click ->
    $("#slide_2").removeClass("active")
    $("#slide_1").addClass("active")
  
  Hlp.Load.reloadLinkMore()
  $("#inputWarning").keypress ->
    $("#searchButton").find('i').show()
    $("#searchButton").find('span').hide()
    $("#searchButton").attr('disabled', 'disabled')
    
  initialize = ->
    maxZoomLevel = 17
    minZoomLevel = 9
    markers = []
    map = new google.maps.Map(document.getElementById("map-canvas"),
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
    )
    defaultBounds = new google.maps.LatLngBounds(new google.maps.LatLng(59.793726, 30.022459), new google.maps.LatLng(60.182502, 30.687132))
    map.fitBounds defaultBounds
    input = (document.getElementById("inputWarning"))
    searchBox = new google.maps.places.SearchBox((input))
    ctaLayer = new google.maps.KmlLayer(url: "http://fog.app.mo2014.ru/mo_spb.kml")
    ctaLayer.setMap map
    
    $("#inputWarning").blur ->
      setTimeout (->
        google.maps.event.trigger( input, 'focus')
        google.maps.event.trigger( input, 'keydown', {keyCode:13})
      ), 500
    google.maps.event.addListener ctaLayer, "click", (kmlEvent) ->
      $("#loader").show()
      name = kmlEvent.featureData.name
      street = $("#inputWarning").val()
      
      $.post("/search", "name=#{name}&street=#{street}")
    
    google.maps.event.addListener searchBox, "places_changed", ->
      
      console.log ctaLayer.getMetadata()
      setTimeout (->
        $("#searchButton").find('i').hide()
        $("#searchButton").find('span').show()
        $("#searchButton").removeAttr('disabled', 'disabled')
      ), 500
      
      
      places = searchBox.getPlaces()
      i = 0
      marker = undefined

      while marker = markers[i]
        marker.setMap null
        i++
      markers = []
      bounds = new google.maps.LatLngBounds()
      i = 0
      place = undefined

      while place = places[i]
        image =
          url: place.icon
          size: new google.maps.Size(71, 71)
          origin: new google.maps.Point(0, 0)
          anchor: new google.maps.Point(17, 34)
          scaledSize: new google.maps.Size(30, 30)

        marker = new google.maps.Marker(
          map: map
          icon: image
          title: place.name
          position: place.geometry.location
          clickable: false
        )
        markers.push marker
        
        bounds.extend place.geometry.location
        i++
      map.fitBounds bounds
      return
    
    
    google.maps.event.addListener map, "bounds_changed", ->
      
      bounds = map.getBounds()
      searchBox.setBounds bounds
      map.setZoom maxZoomLevel  if map.getZoom() > maxZoomLevel
      map.setZoom minZoomLevel  if map.getZoom() < minZoomLevel
      return

    
    return
  google.maps.event.addDomListener window, "load", initialize
  ###################
  $("#testjson").click ->
    $.get("http://maps.googleapis.com/maps/api/geocode/json",
      address: "гаг"
      sensor: false
      language: 'ru'
      components: 'country:ru|administrative_area:Sankt-Petersburg'
    ).done (data) ->
      console.log data
      return
  
  states = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("value")
    queryTokenizer: Bloodhound.tokenizers.whitespace
  
    local: $.map(states, (state) ->
      value: state
    )
  )

  states.initialize()
  $("#bloodhound .typeahead").typeahead
    hint: true
    highlight: true
    minLength: 1
  ,
    name: "states"
    displayKey: "value"
  
    # `ttAdapter` wraps the suggestion engine in an adapter that
    # is compatible with the typeahead jQuery plugin
    source: states.ttAdapter()
  
  
    
  $("#inputWarning1").typeahead
    limit: 1000
    delay: 1500
    source: (query, process) ->
      $.get "http://maps.googleapis.com/maps/api/geocode/json",
        address: query
        sensor: false
        language: 'ru'
        components: 'country:ru|administrative_area:Sankt-Petersburg'
      , (data) ->
        console.log data
        resultList = data.results.map((item) ->
          (item.address_components[1].long_name+" "+item.address_components[0].long_name).toString()
        )
        console.log resultList
        process resultList
      
 

$(document).ready(ready)
$(document).on('page:load', ready)