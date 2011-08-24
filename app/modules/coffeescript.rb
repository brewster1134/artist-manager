require 'haml'

module Coffee
  include ::Haml::Filters::Base

  lazy_require 'coffee-script'

  def render_with_options(text, options)
    <<END
<script type=#{options[:attr_wrapper]}text/javascript#{options[:attr_wrapper]}>
  //<![CDATA[
    #{CoffeeScript.compile(text, options.merge({:bare => true}))}
  //]]>
</script>
END
  end
  
  def self.handler(type)
    @@handler ||=  ActionView::Template.registered_template_handler(type)
  end
  
  def self.call(template)
    compiled_source = defined?(Haml) ? handler(:haml).call(template) : handler(:erb).call(template)
    "::CoffeeScript.compile(begin;#{compiled_source};end)"
  end
end

ActionView::Template.register_template_handler :coffee, Coffee