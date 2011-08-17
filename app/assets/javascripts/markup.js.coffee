//# http://pushingkarma.com/projects/jquery-wysiwym/
//# https://github.com/coreyti/showdown
//= require jquery.wysiwym
//= require showdown

$ ->
  $.each $("div.markup_edit textarea"), ->
    textarea = $(@)
    textarea.wysiwym Wysiwym.Markdown,
      helpEnabled: false
    showdown = new Showdown.converter()
    prev_text = ""
    live_preview = $(document.createElement('div'))
    live_preview.insertAfter(textarea).addClass('markup')
    update_live_preview = ->
      input_text = textarea.val()
      if input_text != prev_text
        text = $("<div>" + showdown.makeHtml(input_text) + "</div>")
        live_preview.html(text)
        prev_text = input_text
    setInterval(update_live_preview, 200)