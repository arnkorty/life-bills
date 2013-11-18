class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  # embedded_in :user_info
  belongs_to :user

  has_many :bills
end
