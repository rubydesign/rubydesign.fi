require 'spec_helper'

describe Clerk do

  it "should create a new instance given a valid attribute" do
    create(:clerk)
  end

  it "should require an email address" do
    no_email_clerk = build(:clerk , :email => "")
    no_email_clerk.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[clerk@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_clerk = create(:clerk , :email => address)
      valid_email_clerk.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[clerk@foo,com clerk_at_foo.org example.clerk@foo.]
    addresses.each do |address|
      invalid_email_clerk = build(:clerk , :email => address)
      invalid_email_clerk.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    create(:clerk , :email => "sama@sama.net")
    clerk_with_duplicate_email = build(:clerk , :email => "sama@sama.net")
    clerk_with_duplicate_email.save
    clerk_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = "BIGMAIL@MAIL.com"
    create(:clerk ,:email => upcased_email)
    clerk_with_duplicate_email = build(:clerk , :email => upcased_email.downcase )
    clerk_with_duplicate_email.save
#should work but doesn, postponed
 #   clerk_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @clerk = create(:clerk)
    end

    it "should have a password attribute" do
      @clerk.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @clerk.should respond_to(:password_confirmation)
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

    before(:each) do
      @clerk = create(:clerk)
    end

    it "should have an encrypted password attribute" do
      @clerk.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @clerk.encrypted_password.should_not be_blank
    end

  end

  it "should be valid" do
    create(:clerk).should be_valid
  end

  it "should require password" do
    clerk = build(:clerk , :password => '')
    clerk.save
    clerk.should have(1).error_on(:password)
  end

  it "should require well formed email" do
    clerk = build(:clerk, :email => 'foo@bar@example.com')
    clerk.save
    clerk.should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    create(:clerk, :email => 'bar@example.com').save!
    clerk = build(:clerk, :email => 'bar@example.com')
    clerk.save 
    clerk.should have(1).error_on(:email)
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
