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
  def images
    self.works.collect{ |w| w.images}.flatten
  end
  def image
    self.images.sample if self.images.present?
  end
  def tags
    self.works.collect{|w| w.tags}.compact.flatten.uniq
  end
  def self.tagged_with(tag)
    (all.collect{ |s| s.works }.flatten & Work.tagged_with(tag)).collect{ |w| w.series}.uniq
  end
  def self.find_by_url(url)
    all.select{ |w| w.url == url }.first
  end

end
