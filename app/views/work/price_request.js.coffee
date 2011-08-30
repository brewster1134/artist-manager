:plain
  price_request = $('div#price_request')
  fieldset = price_request.find('fieldset')
  form = fieldset.find('form#new_email')
  errors = fieldset.find('div#form_errors')

- if @email.valid?
  - SiteMailer.price_request(@work, @email).deliver
  :plain
    form[0].reset()
    price_request.slideUp()
    errors.fadeOut ->
      $(@).remove
    flash = "#{ escape_javascript(render 'shared/flash', :messages => 'Email sent') }"
    $('div#flash').hide().html(flash).fadeIn().delay(2500).fadeOut()
    
- else
  :plain
    error_messages = "#{ escape_javascript(render 'shared/form_errors', :instance => @email) }"
    if errors.html()
      errors.replaceWith error_messages
    else
      fieldset.prepend error_messages
