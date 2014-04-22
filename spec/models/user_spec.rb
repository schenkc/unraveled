require 'spec_helper'

describe User do

  subject(:user) do
    FactoryGirl.build(:user,
      email: "candace.schenk@gmail.com",
      password: "good_password")
    end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it "creates a password digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  it "creates a session token before validation" do
    user.valid?
    expect(user.session_token).to_not be_nil
  end

  it "creates a activation token before saving" do
    user.save
    expect(user.activation_token).to_not be_nil
  end

  describe "#reset_session_token!" do
    it "sets a new session token on the user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?("good_password")).to be_true
    end

    it "verifies a password is not correct" do
      expect(user.is_password?("bad_password")).to be_false
    end
  end

  describe "::find_by_credentials" do
    before { user.save! }

    it "returns user given good credentials" do
     expect(User.find_by_credentials("candace.schenk@gmail.com", "good_password")).to eq(user)
    end

    it "returns nil given bad credentials" do
      expect(User.find_by_credentials("candace.schenk@gmail.com", "bad_password")).to eq(nil)
    end
  end

  describe "associations" do
    it { should have_many(:designs) }
    it "have_many(:liked_patterns) need to think about this"
  end

end
