class NextAction
  include Mongoid::Document
  field :key_word, type: Integer
  field :weixin_type, type: String
  field :event, type: String
  field :remark, type: String
  field :content, type: String
	
	embedded_in :weixin_user

end
