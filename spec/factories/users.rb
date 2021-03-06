FactoryGirl.define do
  factory :user do |u|
    login {"User-#{SecureRandom.hex(2)}"}
    email {|u| "#{u.login}@email.com" }
    password {|u| "password_#{u.login}"}
  end
end
