class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :password, type: String, default: '123456'

  validates :name, presence: true
  validates :user_id, presence: true
  validates_with MasterValidator

  # embedded_in :user_info
  belongs_to :user
  has_many :weixin_user

  has_many :bills
  
  def password_valid?(passwd)
    password == passwd
  end
  
end
