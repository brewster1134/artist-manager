//= require jquery.wysiwym
//= require showdown
$ ->
  textareas = $("textarea.markup")
  textareas.wysiwym Wysiwym.Markdown, {}

  $.each textareas, ->
    showdown = new Showdown.converter()
    prev_text = ""
    update_live_preview = ->
      input_text = textareas.val()
      if input_text != prev_text
        text = $("<div>" + showdown.makeHtml(input_text) + "</div>")
        $('div.markup_livepreview').html(text)
        prev_text = input_text
    setInterval(update_live_preview, 200)