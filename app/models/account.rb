class Account
  include Mongoid::Document
  field :name, type: String

  # embedded_in :user_info
  belongs_to :user

  has_many :bills

end
