class WeixinUser
  include Mongoid::Document 
  include Mongoid::Timestamps
  field :name, type: String
  field :delete_flag, type: Mongoid::Boolean
  field :weixin_id, type: String 
  field :signature, type: String  
  field :request_options, type: Hash
  
  belongs_to :user 

  embeds_many :next_actions

  class << self
    def signature_from(weixin_id)
      wuser = WeixinUser.where(weixin_id: weixin_id).first
      if wuser 
        wuser.signature
      end
    end
  end

  after_create :sigin_up_and_bind

  def sigin_up_and_bind
    next_actions.delete_all  
    next_actions.create([{
                            key_word: 1,remark: '新注册并绑定',
                            weixin_type: 'link', content: "#{Settings.base_url}/weixin_web/user/signup"
                          },{
                            key_word: 2,remark: '已有用户绑定',
                            weixin_type: 'link', content: "#{Settings.base_url}/weixin_web/user/signin"
                          }])
  end

end
