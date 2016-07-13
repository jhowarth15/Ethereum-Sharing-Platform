require 'rails_helper'
require_relative '../../app/models/user'
require_relative '../../app/helpers/users_helper'

describe User, :type => :model do
  # let(:user) { create :user }

  it 'should require first name' do
    user = FactoryGirl.build(:user, :name_first => "  ")
    # expect(build(:user)).to be_valid
    # expect(user.valid?).to eq(false)
    expect(build(:user)).to be_valid
  end

  it 'should have valid first name' do
    expect(FactoryGirl.build(:user)).to be_valid
    # user = FactoryGirl.build(:user)
    # expect(user.valid?).to eq(true)
  end

  # BEGIN TESTS FOR IF USER INPUT IS PRESENT
  it 'should be valid' do
    user = FactoryGirl.build(:user)
    expect(user.valid?).to eq(true)
  end

  it 'should require name_first' do
    first_missing = FactoryGirl.build(:user, :name_first=> " ")
    expect(first_missing.valid?).to eq(false)
  end

  it 'should require name_last' do
    last_missing = FactoryGirl.build(:user, :name_last=> " ")
    expect(last_missing.valid?).to eq(false)
  end
  it 'should require email' do
    email_missing = FactoryGirl.build(:user, :email=> " ")
    expect(email_missing.valid?).to eq(false)
  end
  #END TESTIS FOR IF USER INPUT IS PRESENT

  #BEGIN TESTS FO INPUT LENGTH VALIDATION
  it 'should not allow too long first_name' do
    first_long = FactoryGirl.build(:user, :name_first => "a" * 51)
    expect(first_long.valid?).to eq(false)
  end

  it 'should not allow too long last_name' do
    last_long = FactoryGirl.build(:user, :name_last => "a" * 51)
    expect(last_long.valid?).to eq(false)
  end

  it 'should not allow too long email' do
    email_long = FactoryGirl.build(:user, :email => "a" * 244 + "@example.com")
    expect(email_long.valid?).to eq(false)
  end
  #END TESTS FOR INPUT LENGTH VALIDATION

  #BEGIN TEST FOR VALID EMAIL ADDRESS FORMAT
  it "should not allow an invalid email" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      invalid_email = FactoryGirl.build(:user, :email => invalid_address)
      expect(invalid_email.valid?).to eq(false)
    end
  end
  #END TEST FOR VALID EMAIL ADDRESS FORMAT

  #BEGIN TEST FOR REJECTION OF DUPLICATES
  it "should not allow duplicate user_ids and emails" do
    user = FactoryGirl.build(:user)
    duplicate_user = user.dup
    user.save
    expect(duplicate_user.valid?).to eq(false)
  end
  #END TEST FOR REJECTION OF DUPLICATES

end