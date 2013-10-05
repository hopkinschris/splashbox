require 'spec_helper'

describe User do
  before do
    User.any_instance.stub(:get_dropbox_attributes).and_return(true)
    @user = FactoryGirl.create(:user)
  end

  it "should be deactivatable" do
    @user.deactivate
    expect(@user.deactivated).to eq(true)
  end

  it "should be persistable" do
    expect(@user.valid?).to eq(true)
    expect(@user.save).to eq(true)
  end

  it "should be activatable" do
    @user.activate
    expect(@user.waitlist).to eq(false)
  end

  it "should support waiting scope" do
    expect(User.waiting.count).to eq(1)
    @user.activate
    expect(User.waiting.count).to eq(0)
  end

  it "should support consumers scope" do
    expect(User.consumers.count).to eq(0)
    @user.activate
    expect(User.consumers.count).to eq(1)
  end
end
