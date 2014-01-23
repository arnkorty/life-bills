class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  include CustomBase


  field :bill_type_id, type: Integer
  field :money, type: Float
  field :bill_time, type: Date
  field :remark, type: String
  field :is_enable, type: Boolean

  belongs_to :user

  belongs_to :item
  belongs_to :account
  belongs_to :person

  # validation
  with_options presence: true do |asso|
    asso.validates :item_id
    asso.validates :bill_time
    asso.validates :user_id
    asso.validates :person_id
    asso.validates :account_id
    asso.validates :bill_type_id
  end  
  validates_numericality_of :money
  
  before_validate :set_account
  
  def set_account
    if user.blank? && person
      user = person.user
    end
  end

  scope :type_of,-> (flag) { where(bill_type_id: flag) }

  scope :bills_in_current_month, -> { 
                                            where(
                                              :bill_time.gte => Time.now.at_beginning_of_month,
                                              :bill_time.lte => Time.now.at_end_of_month
                                                )
                                          }
  scope :person_of, -> (person) { where(person_id: person.id) }                                       
  
  def bill_type_name
    Settings.bill_types_zh[bill_type_id] unless  bill_type_id.blank?
  end

  def bill_type_name_en
    Settings.bill_types.each do |key, value|
      return key if value == bill_type_id
    end
  end
  %w(item person account user).each do |m|
    define_method "#{m}_name" do 
      eval(m).try(:name)
    end
  end

  # embedded_in :item
  # embedded_in :account
  # embedded_in :person
end
