# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  flags = (0...Settings.bill_types.size).to_a
  factory :item do
    name "MyString"
    parent_id 0
    flag flags.sample
    
    Settings.bill_types.each do |key,value|
      trait key.to_sym do 
        flag value
      end
    end
  end
end
