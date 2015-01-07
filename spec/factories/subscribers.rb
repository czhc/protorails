FactoryGirl.define do
  factory :subscriber do
    email {"subscriber-#{SecureRandom.hex(2)}@email.com" }
    state :pending
    user
    factory :activated_subscriber do
      after(:create) do |s|
        s.activate!
      end
      factory :unsubscribed_subscriber do
        after(:create) do |s|
          s.unsubscribe!
        end
      end
    end
  end
end
