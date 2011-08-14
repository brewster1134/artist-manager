module SettingsHelper

  def input_hint(key)
    translation = t("simple_form.hints.settings.#{key}")
    translation = nil if translation.index("translation missing")
    ([translation, "Default: #{Settings.defaults[key]}"].compact * '<br />').html_safe
  end
  
end