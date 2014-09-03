$('#candidates').html('<%= escape_javascript(render("welcome/candidates"))%>')
$('#municipality_title').text('<%= @municipality %>')
#Hlp.Load.socialShare()
Hlp.Load.shareLink()
$('.print').click ->
  yaCounter26034489.reachGoal('list_print')
  true
$('.print').printPage()

$("#loader").hide()
yaCounter26034489.reachGoal('success_search')