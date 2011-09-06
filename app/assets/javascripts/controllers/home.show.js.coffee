//= require jquery.hotkeys

$ ->
  $( "fieldset#tags .accordion" ).accordion
    collapsible: true,
    active: false,
    autoHeight: false

  $.get events_path
  
  if enable_hotkey == 'true'
    $(document).bind 'keydown', 'ctrl+l', ->
      window.location = login_path