# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weixin_user do
    user nil
    name "MyString"
    delete_flag false
  end
end
