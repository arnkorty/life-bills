class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :parent_id, type: Integer,default:0
  
  # 0 => outlay, 1 => income
  field :flag,type:Integer,default:0

  # embedded_in :user_info  

  scope :bill_items,->(flag) { where(flag: flag) }
  # scope :outlay_items,-> { where(flag: 1)}

  belongs_to :user

  has_many :bills

end
