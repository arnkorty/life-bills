# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    bill_type_id 1
    item nil
    account nil
    money 1.5
    person nil
    bill_time "2013-11-18 09:57:49"
    remark "MyText"
  end
end
