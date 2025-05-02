FactoryBot.define do
  factory :rsa do
    public_key { "MyString" }
    private_key { "MyString" }
    private_key_iv { "MyString" }
    user { nil }
  end
end
