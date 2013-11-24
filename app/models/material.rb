class Material
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  # 0 defual, 1 base on key_work
  field :rule, type: Integer, default: 0
  field :key_word, type: String

  field :delete_flag, type: Mongoid::Boolean, default: false

  class << self
    def method_missing(*args)
      if args.size == 1
        arg = args.first
        m = where(delete_flag: false).where(rule: 0).where(key_word: arg).desc.first
        if m
          # metaclass.instance_eval do
            define_method arg do
              ## 重新查询，以防修改后使用不能反应到函数
              where(delete_flag: false).where(rule: 0).where(key_word: arg).desc.first.content
            end
            m.content
          # end
        else
          super
        end
      else
        super
      end
    end
  end
end
