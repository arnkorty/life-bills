class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  include CustomBase

  field :name, type: String
  field :parent_id, type: Integer, default: 0
  
  # 0 => outlay, 1 => income
  field :flag,type: Integer,default: 0

  # embedded_in :user_info  

  validates :name, presence: true
  validates :user_id, presence: true
  validates_with MasterValidator


  scope :bill_items, ->(flag) { where(flag: flag) }
  scope :rel_items, -> {  }
  # scope :outlay_items,-> { where(flag: 1)}


  # def validate
  #   if user_id.blank?
  #     errors.add :user_id, 'must belongs a user'      
  #   else
  #     unless user.items.where(name: name).blank?
  #       errors.add :name, 'name must uniq'
  #     end
  #   end
  # end

  belongs_to :user

  has_many :bills

  def items
    Item.where(parent_id: id)
  end
  def item
    [self]
  end
end
