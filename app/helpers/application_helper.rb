module ApplicationHelper
  require 'redcarpet'

  def include_controller_assets(type, controller_name, action_name)
    case type
    when :javascript, :js
      dir = "javascripts"
      ext = [".js.coffee", ".js.coffee.haml"]
      helper = "javascript_include_tag" 
    when :stylesheet, :css
      dir = "stylesheets"
      ext = [".css.sass", ".css.sass.erb"]
      helper = "stylesheet_link_tag" 
    end
    action_name = case action_name
    when "create" then "new"  
    when "update" then "edit"
    else action_name
    end  
    sub_directory = "controllers"
    names = [ controller_name, "#{controller_name}.#{action_name}"]
    files = []
    names.each do |n|
      ext.each do |e|
        file_exists = File.exists?(File.join(Rails.root, "app", "assets", dir, sub_directory, n + e))
        files << send(helper, File.join(sub_directory, n + e)) if file_exists
      end
    end
    return (files * "").html_safe
  end

  def site_title
    title = if content_for?(:page_title) && !content_for?(:title)
      content_for(:page_title)
    elsif content_for?(:title)
      content_for(:title)
    else
      nil
    end
    return [Settings.title, title].compact * " - "
  end

  def page_title
    return content_for(:page_title) if content_for?(:page_title)
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

  # = toggle_link :element_id
  # #element_id
  # = toggle_link :hidden_element, :state => :hide
  # #hidden_element.hide
  def toggle_link(name, options = {})
    options.reverse_merge!({
      :element_id =>  name,
      :state =>       :show
    })
    state_opposite = {:show => :hide, :hide => :show}
    initial_text = "#{state_opposite[options[:state]]}_#{name}".titleize
    toggled_text = "#{options[:state]}_#{name}".titleize
    link_to_function initial_text, "$(this).toggle('#{options[:element_id]}', '#{options[:state]}', 'Show #{options[:element_id]}', 'Hide #{options[:element_id]}')", :class => :toggle_link, :id => "toggle_#{options[:element_id]}_link", "data-default-state" => options[:state]
  end
  
end
