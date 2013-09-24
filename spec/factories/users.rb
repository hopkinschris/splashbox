FactoryGirl.define do
  factory :user do
    name "Foo Bar"
    email "foo@bar.com"
    waitlist "true"
    deactivated "false"
  end
end
