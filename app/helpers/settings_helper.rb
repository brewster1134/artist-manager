module SettingsHelper

  def input_hint(key)
    translation = t("simple_form.hints.settings.#{key}")
    translation = nil if translation.index("translation missing")
    ([translation, "Default: #{Settings.defaults[key]}"].compact * '<br />').html_safe
  end
  
  def image_sizes_inputs
    html = "<div id='image_sizes'>"
    Settings.image_sizes.each do |controller, actions|
      html << "<div>"
      html << content_tag(:h2, controller.titleize, :class => "controller")
      html << "<table>"
      actions.each do |action, image_instances|
        html << "<tr>"
        html << "<th>#{action.titleize} Page</th>"
        html << "<th>Width</th>"
        html << "<th>Height</th>"
        html << "</tr>"
        
        # <input type="text" value="Events" size="50" name="settings[google_calendar]" id="settings_google_calendar" class="string optional">
        # text_field_tag 'name'
        
        image_instances.each do |instance, sizes|
          html << "<tr><td>#{instance.titleize}</td>"
          html << if sizes[:width]
            "<td>#{ text_field_tag 'settings[image_sizes][' + controller + '][' + action + '][' + instance + '][width]', sizes[:width], :id => 'settings_image_sizes_' + controller + '_' + action + '_' + instance + '_width', :class => 'string optional', :size => 4 }</td>"
          else
            "<td></td>"
          end
          
          html << if sizes[:height]
            "<td>#{ text_field_tag 'settings[image_sizes][' + controller + '][' + action + '][' + instance + '][height]', sizes[:height], :id => 'settings_image_sizes_' + controller + '_' + action + '_' + instance + '_height', :class => 'string optional', :size => 4 }</td>"
          else
            "<td></td>"
          end
          html << "</tr>"
        end
      end
      html << "</table>"
      html << "</div>"
    end
    html << "</div>"
    html.html_safe
  end
  
end