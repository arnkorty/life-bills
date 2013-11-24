class WeixinUser
  include Mongoid::Document
  field :name, type: String
  field :delete_flag, type: Mongoid::Boolean
  belongs_to :user
end
