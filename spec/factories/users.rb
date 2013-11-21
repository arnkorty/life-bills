# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sample_login = ['john', 'Lee', 'Adely', 'lily', 'Oliver', 'beth'].sample  
  sample_password = ['DJX5nvyX', 'GG83Sr4{', '_pW.2P*8', 'MH^IN3B_'].sample
  sequence(:email) { |n| "#{sample_login}#{n}@arnkorty.info".downcase }


  factory :user do
    # login
    email

    password sample_password

    trait :second_user do 
      email "#{sample_login}_2@arnkorty.info"
    end
  end
end
