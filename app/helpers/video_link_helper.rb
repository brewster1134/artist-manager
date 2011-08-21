require "uri"
require "rack"

module VideoLinkHelper
  
  def embed_video(video_link)
    if uri = valid_video?(video_link)
      host = uri.host
      case host
      when /youtu/
        embed_youtube(uri)
      end
    end
  end
  
  def valid_video?(video_link)
    uri = URI.parse(video_link) rescue nil
    if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      return uri
    else
      return false
    end
  end
  
  def embed_youtube(uri)
    case uri.host
    when /youtube.com/
      env = Rack::MockRequest.env_for(uri.to_s)
      req = Rack::Request.new(env)
      video_id = req.params["v"]
    when /youtu.be/
      video_id = uri.path.delete("/")
    end
    content_tag(:iframe, nil, :width => "100%", :height => "400px", :src => "http://www.youtube-nocookie.com/embed/#{video_id}?theme=dark&color=white&rel=0", :frameborder => "0", :allowfullscreen => true, :preserveAspectRatio => "align", :class => "video youtube") unless video_id.blank?
  end
  private :embed_youtube
  
end