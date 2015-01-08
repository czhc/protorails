FactoryGirl.define do
  factory :article do
    title "Title #{SecureRandom.hex(2)}"
    text Forgery(:lorem_ipsum).words(5)
  end
end
