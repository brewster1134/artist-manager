$ ->
  $( "fieldset#tags .accordion" ).accordion
    collapsible: true,
    active: false,
    autoHeight: false

  $.get events_path