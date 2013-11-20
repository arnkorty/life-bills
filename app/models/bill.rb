class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :bill_type_id, type: Integer
  field :money, type: Float
  field :bill_time, type: DateTime
  field :remark, type: String

  belongs_to :user

  belongs_to :item
  belongs_to :account
  belongs_to :person

  # validation
  validates_presence_of     :item_id
  validates_presence_of     :bill_time
  validates_numericality_of :money

  scope :bill_type_of,-> (flag) { where(bill_type_id: flag) }


  # embedded_in :item
  # embedded_in :account
  # embedded_in :person
end
