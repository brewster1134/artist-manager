class Email
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :to, :from, :subject, :message, :skip
  
  validates :to,        :presence => true,
                        :email => true,
                        :unless => Proc.new { skip_validation(:to) }
  validates :from,      :presence => true,
                        :email => true,
                        :unless => Proc.new { skip_validation(:from) }
  validates :subject,   :presence => true,
                        :unless => Proc.new { skip_validation(:subject) }
  validates :message,   :presence => true,
                        :unless => Proc.new { skip_validation(:message) }
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def skip_validation(attr)
    self.skip.include?(attr) if self.skip
  end
  
  def persisted?; false; end
end
