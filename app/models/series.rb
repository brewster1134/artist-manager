class Series < ActiveRecord::Base
  has_many :works
  attr_accessible :title, :description

  validates :title,       :presence => true,
                          :uniqueness => true

  def url
    self.title.parameterize
  end
  def to_param
    url
  end
  def image
    if (images = self.works.collect{ |w| w.images}.flatten).present?
      images.sample
    end
  end
  def self.tagged_with(tag)
    (all.collect{ |s| s.works }.flatten & Work.tagged_with(tag)).collect{ |w| w.series}.uniq
  end
  def self.find_by_url(url)
    all.select{ |w| w.url == url }.first
  end

end
