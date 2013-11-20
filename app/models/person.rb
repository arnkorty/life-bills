class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates :name, presence: true
  validates :user_id, presence: true
  validates_with MasterValidator

  # embedded_in :user_info
  belongs_to :user

  has_many :bills
end
