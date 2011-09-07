module ApplicationHelper
  require 'redcarpet'

  def include_controller_assets(type, controller_name, action_name)
    case type
    when :javascript, :js
      dir = "javascripts"
      ext = [".js.coffee", ".js.coffee.erb"]
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

  def logo
    logo_path = File.join(Rails.root, 'public', 'uploads')
    logo = Dir.glob(File.join(logo_path, 'logo.*')).first || ""
    
    content = if Settings.use_logo && File.exists?(logo)
      logo_filename = File.basename(logo)
      image_tag(File.join("/uploads/#{logo_filename}"))
    else
      Settings.title
    end
    return link_to content, home_path, :alt => Settings.title, :id => "logo"
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
    div_class = options.delete(:class)
    options.reject! { |k, v| !v }
    content_tag(:div, Redcarpet.new(text.to_s, *options.keys).to_html.html_safe, :class => "markup #{div_class}")
  end
  
  def currency_select_array
    Money::Currency::TABLE.collect{ |symbol, currency| ["#{currency[:iso_code]} - #{currency[:name]}", symbol.to_s] }.sort
  end

  # = toggle_link :element_id
  # #element_id
  # = toggle_link :hidden_element, :state => :hide
  # #hidden_element.hide
  def toggle_link(element_id, options = {})
    state_opposite = {:show => :hide, :hide => :show}
    options.reverse_merge!({
      :element_id =>  element_id,
      :state      =>  :show,
      :name       =>  [state_opposite[options[:state]], element_id] * " ".to_s.titleize
    })
    options[:show_name] ||= (options[:name] ? "Show #{element_id.to_s.titleize}" : "Show")
    options[:hide_name] ||= (options[:name] ? "Hide #{element_id.to_s.titleize}" : "Hide")
    link_to_function (options[:name] || state_opposite[options[:state]]).to_s.titleize, "$(this).toggle('#{options[:element_id]}', '#{options[:state]}', '#{options[:show_name]}', '#{options[:hide_name]}')", :class => :toggle_link, :id => "toggle_#{options[:element_id]}_link", "data-default-state" => options[:state]
  end

  def footer
    footer_html = "Site by "
    footer_html << link_to("Man Alive!", "http://www.wearemanalive.com", :target => "_blank")
    return footer_html.html_safe
  end
  
end
