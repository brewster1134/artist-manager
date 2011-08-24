events = $('fieldset#events .accordion')
- if @events.is_a?(Array) && @events.present?
  :plain
    events.html("#{ escape_javascript(render "events_accordion", :events => @events) }")
    events.accordion
      autoHeight: false
- else
  :plain
    events.html(" #{ escape_javascript(current_user ? @events.to_s : 'No Events Found') } ")