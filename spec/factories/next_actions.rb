# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :next_action do
    key_word 1
    event "MyString"
    content "MyString"
  end
end
