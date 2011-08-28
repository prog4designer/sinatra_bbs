class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :message, type: String
  
  validates :message, :presence => true
end