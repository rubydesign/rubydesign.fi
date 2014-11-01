require 'spec_helper'

describe Clerk do

  describe "passwords" do

    it "should have a password attribute" do
      create(:clerk).should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      create(:clerk).should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      cl = build(:clerk , :password => "", :password_confirmation => "")
      expect(cl).not_to be_valid
    end

    it "should require a matching password confirmation" do
      clerk = build(:clerk , :password_confirmation => "invalid")
      expect(clerk).not_to be_valid
    end

  end

  describe "password encryption" do

    it "should have an encrypted password attribute" do
      create(:clerk).should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(create(:clerk).encrypted_password).not_to be_blank
    end

  end

  it "should require password" do
    clerk = build(:clerk , :password => '')
    clerk.save
    expect(clerk.errors[:password]).not_to be nil
  end


  # would be nice, just doesn't work yet
#  it "should not allow odd characters in name" do
#    create(:clerk, :name => 'odd ^&(@)').should have(1).error_on(:name)
#  end

  it "should validate password is longer than 3 characters" do
    clerk = build(:clerk, :password => 'bad')
    clerk.save
    expect(clerk.errors[:password]).not_to be nil
  end

  it "should require matching password confirmation" do
    clerk = build(:clerk, :password_confirmation => 'nonmatching')
    clerk.save
    expect(clerk.errors[:password]).not_to be_nil
  end

  it "should generate password hash and salt on create" do
    clerk = create(:clerk)
    clerk.save!
    expect(clerk.encrypted_password).not_to be nil
    expect(clerk.password_salt).not_to be_nil
  end

  it "should authenticate" do
    clerk = create(:clerk)
    expect(clerk.valid_password?('password')).to be true
  end

  it "should not authenticate bad password" do
    clerk = create(:clerk)
    expect(clerk.valid_password?('badpassword')).to be false
  end

end
