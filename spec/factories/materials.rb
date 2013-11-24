# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :material do
    name "MyString"
    content "MyText"
    rule 1
    key_work "MyString"
    delete_flag "MyString"
  end
end
