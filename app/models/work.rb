class Work < ActiveRecord::Base
  acts_as_taggable
  has_many :images, :class_name => "WorkImage", :dependent => :destroy
  belongs_to :series
  attr_accessible :title, :series_id, :tag_list, :description, :media, :dimensions, :completion_year, :video_link, :for_sale, :price, :price_currency, :quantity
  
  validates :title,           presence:   true,
                              uniqueness: true
  validates :completion_year, numericality: {
                                greater_than_or_equal_to: 100.years.ago.year,
                                less_than_or_equal_to:    Date.today.year
                              },
                              allow_blank: true
  validates :video_link,      format:       { with: URI::regexp },
                              allow_blank: true
  validates :for_sale,        inclusion:    { in: [true, false] }
  validates :price,           numericality: { greater_than_or_equal_to: 0 }
  validates :price_currency,  inclusion:    { in: Money::Currency::TABLE.stringify_keys.keys }
  validates :quantity,        numericality: { greater_than_or_equal_to: 0 }
  
  def price
    Money.new(self.price_cents.to_i || 0, self.price_currency || Money.default_currency)
  end
  def price=(price)
    self.price_cents = Money.parse(price).cents
  end  

  def self.not_in_series
    all.select{|w| w.series.blank?}
  end
  def image
    self.images.present? ? self.images.sample : nil
  end

  def url
    self.title.parameterize
  end
  def to_param
    url
  end
  def self.find_by_url(url)
    all.select{ |w| w.url == url }.first
  end

end
