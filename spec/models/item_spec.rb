require 'spec_helper'

describe Item do
  let(:user) { create :user }
  let(:item) { FactoryGirl.build(:item)  }  
  subject { item }


  it 'passes lidatation with all valid informations' do
    expect(user.accounts.build :name=> "Json bank" ).to be_valid
  end

  context 'favalidation' do 
    context 'name' do 
      context 'is blank' do 
        before{ 
          item.user_id = user.id
          item.name    = ''          
        }
        its(:valid?){ should be_false }
      end
      context 'name is uniq in a user' do
        # context 'user has tow same item' do 
          before{
            user.items.create(name: 'Josh Lee')
          }
          it 'user has tow same item ' do 
            subject.user = user 
            subject.name = 'Josh Lee'            
            subject.valid?.should be_false
            subject.errors[:name].should eql ['name must uniq']            
          end

          it 'difference user has some item ' do 
            u = create :user,:second_user                        
            subject.user = u 
            subject.name = 'Josh Lee'
            subject.valid?.should be_true
          end          
        # end
      end
    end
    context 'user' do 
      context 'must belongs_to a user' do        
        it 'belongs_to user' do 
          subject.valid?.should be_false
          subject.errors[:user_id].should eql ["can't be blank"]          
        end
      end
    end

    context 'flag' do 
      context 'test bill type' do 
        it 'valid income type flag' do
          item = build :item, :income
          item.flag.should == Settings.bill_types.income
        end
      end
    end
  end
end
