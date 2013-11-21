class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  include CustomBase


  field :bill_type_id, type: Integer
  field :money, type: Float
  field :bill_time, type: Date
  field :remark, type: String

  belongs_to :user

  belongs_to :item
  belongs_to :account
  belongs_to :person

  # validation
  validates_presence_of     :item_id
  validates_presence_of     :bill_time
  validates_presence_of     :user_id
  validates_presence_of     :person_id
  validates_presence_of     :account_id
  validates_numericality_of :money

  scope :bill_type_of,-> (flag) { where(bill_type_id: flag) }

  def bill_type_name
    Settings.bill_types_zh[bill_type_id] unless  bill_type_id.blank?
  end

  def bill_type_name_en
    Settings.bill_types.each do |key, value|
      return key if value == bill_type_id
    end
  end
  # embedded_in :item
  # embedded_in :account
  # embedded_in :person
end
