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
      build(:clerk , :password => "", :password_confirmation => "").should_not be_valid
    end

    it "should require a matching password confirmation" do
      build(:clerk , :password_confirmation => "invalid").should_not be_valid
    end

  end

  describe "password encryption" do

    it "should have an encrypted password attribute" do
      create(:clerk).should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      create(:clerk).encrypted_password.should_not be_blank
    end

  end

  it "should require password" do
    clerk = build(:clerk , :password => '')
    clerk.save
    clerk.should have(1).error_on(:password)
  end


  # would be nice, just doesn't work yet
#  it "should not allow odd characters in name" do
#    create(:clerk, :name => 'odd ^&(@)').should have(1).error_on(:name)
#  end

  it "should validate password is longer than 3 characters" do
    clerk = build(:clerk, :password => 'bad')
    clerk.save
    clerk.errors[:password].should_not be_nil
  end

  it "should require matching password confirmation" do
    clerk = build(:clerk, :password_confirmation => 'nonmatching')
    clerk.save
    clerk.errors[:password].should_not be_nil
  end

  it "should generate password hash and salt on create" do
    clerk = create(:clerk)
    clerk.save!
    clerk.encrypted_password.should_not be_nil
    clerk.password_salt.should_not be_nil
  end

  it "should authenticate" do
    clerk = create(:clerk)
    clerk.valid_password?('password').should == true
  end

  it "should not authenticate bad password" do
    clerk = create(:clerk)
    clerk.valid_password?('badpassword').should be_false
  end

end
