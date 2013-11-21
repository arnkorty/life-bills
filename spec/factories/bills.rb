# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  bill_types = (0..3).to_a

  factory :bill do
    bill_type_id bill_types.sample
    item nil
    account nil
    money 1.5
    person nil
    user nil
    bill_time "2013-11-18 09:57:49"
    remark "MyText"
  end
end
