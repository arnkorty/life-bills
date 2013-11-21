require 'spec_helper'

describe Person do
    let(:user) { create :user }
  let(:person) { FactoryGirl.build(:person)  }  
  subject { person }


  it 'passes lidatation with all valid informations' do
    expect(user.people.build :name=> "Json bank" ).to be_valid
  end

  context 'favalidation' do 
    context 'name' do 
      context 'is blank' do 
        before{ 
          person.user_id = user.id
          person.name    = ''          
        }
        its(:valid?){ should be_false }
      end
      context 'name is uniq in a user' do
        # context 'user has tow same person' do 
          before{
            user.people.create(name: 'Josh Lee')
          }
          it 'user has tow same person ' do 
            subject.user = user 
            subject.name = 'Josh Lee'            
            subject.valid?.should be_false
            subject.errors[:name].should eql ['name must uniq']            
          end

          it 'difference user has some person ' do 
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
        before{          
        }
        it 'belongs_to user' do 
          subject.valid?.should be_false
          subject.errors[:user_id].should eql ["can't be blank"]          
        end
      end
    end
  end
end
