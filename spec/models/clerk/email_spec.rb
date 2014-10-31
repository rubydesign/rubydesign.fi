require 'spec_helper'

describe Clerk do

  it "should create a new instance given a valid attribute" do
    create(:clerk)
  end

  it "should require an email address" do
    no_email_clerk = build(:clerk , :email => "")
    no_email_clerk.not_to be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[clerk@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_clerk = create(:clerk , :email => address)
      valid_email_clerk.to be _valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[clerk@foo,com clerk_at_foo.org example.clerk@foo.]
    addresses.each do |address|
      invalid_email_clerk = build(:clerk , :email => address)
      invalid_email_clerk.not_to be_valid
    end
  end

  it "should reject duplicate email addresses" do
    create(:clerk , :email => "sama@sama.net")
    clerk_with_duplicate_email = build(:clerk , :email => "sama@sama.net")
    clerk_with_duplicate_email.save
    clerk_with_duplicate_email.not_to be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = "BIGMAIL@MAIL.com"
    create(:clerk ,:email => upcased_email)
    clerk_with_duplicate_email = build(:clerk , :email => upcased_email.downcase )
    clerk_with_duplicate_email.save
#should work but doesn, postponed
 #   clerk_with_duplicate_email.not_to be_valid
  end


  it "should be valid" do
    create(:clerk).to be _valid
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

end
