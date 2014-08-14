$('#candidates').html('<%= escape_javascript(render("welcome/candidates"))%>')
$('#municipality_title').text('<%= @municipality %>')
