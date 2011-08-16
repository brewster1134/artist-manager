module ApplicationHelper
  require 'redcarpet'

  def include_controller_asset(name, type)
    case type
    when :javascript, :js
      dir = "javascripts"
      ext = [".js.coffee", ".js.coffee.haml"]
      helper = "javascript_include_tag" 
    when :stylesheet, :css
      dir = "stylesheets"
      ext = [".css.sass", ".css.sass.haml"]
      helper = "stylesheet_link_tag" 
    end
    ext.each do |e|
      file_exists = File.exists?(File.join(Rails.root, "app", "assets", dir, "controllers", name.to_s + e))
      return send(helper, File.join("controllers", "#{name}#{e}")) if file_exists
    end
  end

  def page_title
    return content_for(:page_title) if content_for?(:page_title)
    return content_for(:title) if content_for?(:title)
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
