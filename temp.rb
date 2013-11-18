class User
  include Mongoid::Document

  embeds_many :items  
end

class Item
	include Mongoid::Document

	field :name,type:String

	embedded_in :user
end
# you can create embedded documents such as 
User.create.items.create([{:name => 'foo'},{:name => 'bar'}])

