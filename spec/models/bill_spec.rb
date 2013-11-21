require 'spec_helper'

describe Bill do
  let(:user) { create :user }
  let(:account) { user.accounts.create name: 'Test Bank' }
  let(:item) { user.items.create name: 'Test Item' }
  let(:person) { user.people.create name: 'Test Person' }

  let(:bill) { build :bill }
  subject{ bill }

  it "passes validation with all valid informations" do
    # expect(build :bill).to be_valid
  end

  context 'fails valid' do
    context 'init validation' do 
      its(:valid?) { should be_false }
    end
    context  do 
      before{
        subject.user    = user 
        subject.account = account
        subject.item    = item 
        subject.person  = person
      }

      it 'validation valid data' do 
        subject.valid?.should be_true
      end

      it 'validation item' do 
        subject.item = nil
        subject.valid?.should be_false
      end  
      it 'validation person' do 
        subject.person = nil
        subject.valid?.should be_false
      end  
      it 'validation account' do 
        subject.account = nil
        subject.valid?.should be_false
      end  
      it 'validation user' do 
        subject.user = nil
        subject.valid?.should be_false
      end  
      it 'validation money' do 
        subject.money = nil
        subject.valid?.should be_false
      end
      it 'save valid data'  do 
        subject.bill_time = nil
        subject.valid?.should be_false
        subject.bill_time = Time.now
        subject.valid?.should be_true
      end
    end
  end
end
