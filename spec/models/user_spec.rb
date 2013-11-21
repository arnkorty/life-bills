require 'spec_helper'

describe User do    

  let(:user) { build :user }
  subject{ user }

  it "passes validation with all valid informations" do
    expect(build :user).to be_valid
  end

  context 'fails validation' do 
    context 'email' do 
      it 'email format' do 
        subject.email = 'fsffsdf'
        subject.valid?.should be_false
        subject.email = 'fsfhio@@%@#'
        subject.valid?.should be_false
      end
      it 'email is blank' do 
        subject.email = nil
        subject.valid?.should be_false
      end
    end    
  end
  describe 'init create user' do 
    it 'init data validation' do 
      subject.valid?.should be_true
    end
    it 'create init data validation' do 
      subject.save

      subject.items.size.should > 0
      subject.people.size.should > 0
      subject.accounts.size.should > 0

      subject.items.first.name.should eql '无'
      subject.people.first.name.should eql '无'
      subject.accounts.first.name.should eql '无'
    end
  end
end
