FactoryGirl.define do
  factory :subscriber do
    email {"subscriber-#{SecureRandom.hex(2)}@email.com" }
    state :pending
    association :user
  end

  factory :activated_subscriber do
    email {"subscriber-#{SecureRandom.hex(2)}@email.com" }
    state :activated
    association :user
  end

end
