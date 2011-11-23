class Work < ActiveRecord::Base
  acts_as_taggable
  has_many :images, :class_name => "WorkImage", :dependent => :destroy
  belongs_to :series
  attr_accessible :title, :series_id, :tag_list, :description, :media, :dimensions, :completion_year, :video_link, :for_sale, :price, :price_currency, :quantity, :view, :featured, :shipping, :shipping_currency
  
  validates :title,             presence:   true,
                                uniqueness: true,
                                format: { with: /^[a-zA-Z0-9]+[a-zA-Z0-9\s\-_]/ }
  validates :completion_year,   numericality: {
                                  greater_than_or_equal_to: 100.years.ago.year,
                                  less_than_or_equal_to:    Date.today.year
                                },
                                allow_blank: true
  validates :video_link,        format:       { with: URI::regexp },
                                allow_blank: true
  validates :for_sale,          inclusion:    { in: [true, false] }
  validates :price,             numericality: { greater_than_or_equal_to: 0 }
  validates :price_currency,    inclusion:    { in: Money::Currency::TABLE.stringify_keys.keys }
  validates :shipping,          numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_currency, inclusion:    { in: Money::Currency::TABLE.stringify_keys.keys }
  validates :quantity,          numericality: { greater_than_or_equal_to: 0 }
  validates :view,              inclusion:    { in: Settings.site[:work_show_views].collect{ |v| v.to_s} },
                                allow_blank: true
  validates :featured,          inclusion:    { in: [true, false] }
  
  # class methods
  def self.find_by_url(url)
    all.select{ |w| w.url == url }.first
  end

  def self.tags
    tag_counts.sort_by(&:count).reverse
  end

  def self.not_in_series(tag = nil)
    without_series = all.select{|w| w.series.blank?}
    without_series = without_series & Work.tagged_with(tag) if tag
    without_series
  end

  # instance methods
  def url
    self.title.parameterize
  end

  def to_param
    url
  end

  def price
    Money.new(self.price_cents.to_i || 0, self.price_currency || Money.default_currency)
  end

  def price=(price)
    self.price_cents = Money.parse(price).cents
  end  

  def shipping
    Money.new(self.shipping_cents.to_i || 0, self.shipping_currency || Money.default_currency)
  end

  def shipping=(shipping)
    self.shipping_cents = Money.parse(shipping).cents
  end  

  def image
    self.images.present? ? self.images.sample : nil
  end

  def sold_out?
    self.for_sale && self.quantity == 0
  end

  def price?
    self.price > 0
  end

  def shipping?
    self.shipping > 0
  end

  def can_buy_on_site?
    self.for_sale && !self.sold_out? && self.price? && [Settings.paypal_api_username, Settings.paypal_api_password, Settings.paypal_api_signature].all?
  end

  def can_request_price?
    self.for_sale && !self.sold_out? && !self.price?
  end

  def total_price
    self.price + self.shipping
  end

  def name
    [(self.series.title if self.series), self.title].compact * ": "
  end
    
end
