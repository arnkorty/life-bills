class Bill
  include Mongoid::Document
  field :bill_type_id, type: Integer
  field :money, type: Float
  field :bill_time, type: DateTime
  field :remark, type: String

  belongs_to :user

  belongs_to :item
  belongs_to :account
  belongs_to :person
  # embedded_in :item
  # embedded_in :account
  # embedded_in :person
end
