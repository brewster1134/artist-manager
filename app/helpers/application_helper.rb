module ApplicationHelper
  require 'redcarpet'

  def include_controller_asset(name, type)
    case type
    when :javascript, :js
      dir = "javascripts"
      ext = ".js.coffee"
      helper = "javascript_include_tag" 
    when :stylesheet, :css
      dir = "stylesheets"
      ext = ".css.sass"
      helper = "stylesheet_link_tag" 
    end
    file_exists = File.exists?(File.join(Rails.root, "app", "assets", dir, "controllers", name.to_s + ext))
    send(helper, File.join("controllers", name)) if file_exists
  end

  def markup(text, options = {})
    # http://rdoc.info/github/tanoku/redcarpet/master/Redcarpet
    options.reverse_merge!(
      :autolink =>          false,
      :filter_html =>       true,
      :filter_styles =>     true,
      :generate_toc =>      false,
      :gh_blockcode =>      true,
      :hard_wrap =>         true,
      :lax_htmlblock =>     false,
      :no_image =>          true,
      :no_intraemphasis =>  false,
      :no_links =>          false,
      :safelink =>          true,
      :smart =>             false,
      :space_header =>      false,
      :xhtml =>             true
    )
    options.reject! { |k, v| !v }
    content_tag(:div, Redcarpet.new(text.to_s, *options.keys).to_html.html_safe, :class => "markup")
  end
  
  def currency_select_array
    Money::Currency::TABLE.collect{ |symbol, currency| ["#{currency[:iso_code]} - #{currency[:name]}", symbol.to_s] }.sort
  end
  
end
