class WeixinUser
  include Mongoid::Document 
  include Mongoid::Timestamps
  field :name, type: String
  field :delete_flag, type: Mongoid::Boolean
  field :weixin_id, type: String 
  field :signature, type: String  
  field :request_options, type: Hash
  field :type_flag, type: String
  
  belongs_to :user 
  belongs_to :person

  embeds_many :next_actions
  

  def user_or_person
    type_flag == 'user' ? user : person
  end
  
  class << self
    def signature_from(weixin_id)
      wuser = WeixinUser.where(weixin_id: weixin_id).first
      if wuser 
        wuser.signature
      end
    end
    def try_content(attr)
      m = Material.where(delete_flag: false,rule: 0,key_word: attr).first
      if m 
        m.content
      else
        attr
      end
    end
  end

  after_create :sigin_up_and_bind

  def sigin_up_and_bind
    next_actions.delete_all  
    next_actions.create([{
                            key_word: 1,remark: '登录并绑定',
                            weixin_type: 'link', content: short_url("weixin_web/user/signin")
                          },{
                            key_word: 2,remark: '新注册并绑定',
                            weixin_type: 'link', content: short_url("weixin_web/user/signup")
                          }])
  end  

  def after_bind_for_action
    next_actions.delete_all
    next_actions.create([{
                            key_word: 21,remark: '查看账单',
                            weixin_type: 'link', content: short_url("weixin_web/bills")
                          },{
                            key_word: 22,remark: '添加账单',
                            weixin_type: 'link', content: short_url("weixin_web/bills/new")
                          }])
  end

  def short_url(action)
    Settings.base_url + '/url/' + ShortUrl.generate("#{Settings.base_url}/#{action}?#{valid_str}")
  end

  def valid_str
    "weixin_id=#{weixin_id}&signature=#{signature}"
  end

end
