FactoryBot.define do
  sequence :email do |n|
    "email_#{n}@example.com"
  end
end
