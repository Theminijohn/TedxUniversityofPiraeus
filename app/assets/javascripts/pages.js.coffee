jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

# Speakers Tab
$ ->
  $("#SpeakersTab a:first").tab "show"