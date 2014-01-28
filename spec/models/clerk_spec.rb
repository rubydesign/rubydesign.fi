require 'spec_helper'

describe Clerk do

  before(:each) do
    @attr = {
      :name => "Example Clerk",
      :email => "clerk@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    Clerk.create!(@attr)
  end

  it "should require an email address" do
    no_email_clerk = Clerk.new(@attr.merge(:email => ""))
    no_email_clerk.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[clerk@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_clerk = Clerk.new(@attr.merge(:email => address))
      valid_email_clerk.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[clerk@foo,com clerk_at_foo.org example.clerk@foo.]
    addresses.each do |address|
      invalid_email_clerk = Clerk.new(@attr.merge(:email => address))
      invalid_email_clerk.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Clerk.create!(@attr)
    clerk_with_duplicate_email = Clerk.new(@attr)
    clerk_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Clerk.create!(@attr.merge(:email => upcased_email))
    clerk_with_duplicate_email = Clerk.new(@attr)
    clerk_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @clerk = Clerk.new(@attr)
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
      Clerk.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Clerk.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Clerk.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @clerk = Clerk.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @clerk.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @clerk.encrypted_password.should_not be_blank
    end

  end


  def new_clerk(attributes = {})
    attributes[:clerkname] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    Clerk.new(attributes)
  end

  before(:each) do
    Clerk.delete_all
  end

  it "should be valid" do
    new_clerk.should be_valid
  end

  it "should require clerkname" do
    new_clerk(:clerkname => '').should have(1).error_on(:clerkname)
  end

  it "should require password" do
    new_clerk(:password => '').should have(1).error_on(:password)
  end

  it "should require well formed email" do
    new_clerk(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    new_clerk(:email => 'bar@example.com').save!
    new_clerk(:email => 'bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of clerkname" do
    new_clerk(:clerkname => 'uniquename').save!
    new_clerk(:clerkname => 'uniquename').should have(1).error_on(:clerkname)
  end

  it "should not allow odd characters in clerkname" do
    new_clerk(:clerkname => 'odd ^&(@)').should have(1).error_on(:clerkname)
  end

  it "should validate password is longer than 3 characters" do
    new_clerk(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_clerk(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should generate password hash and salt on create" do
    clerk = new_clerk
    clerk.save!
    clerk.encrypted_password.should_not be_nil
    clerk.password_salt.should_not be_nil
  end

  it "should authenticate by clerkname" do
    clerk = new_clerk(:clerkname => 'foobar', :password => 'secret')
    clerk.save!
    Clerk.authenticate('foobar', 'secret').should == clerk
  end

  it "should authenticate by email" do
    clerk = new_clerk(:email => 'foo@bar.com', :password => 'secret')
    clerk.save!
    Clerk.authenticate('foo@bar.com', 'secret').should == clerk
  end

  it "should not authenticate bad clerkname" do
    Clerk.authenticate('nonexisting', 'secret').should be_nil
  end

  it "should not authenticate bad password" do
    new_clerk(:clerkname => 'foobar', :password => 'secret').save!
    Clerk.authenticate('foobar', 'badpassword').should be_nil
  end

end
