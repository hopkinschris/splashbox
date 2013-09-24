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
end
