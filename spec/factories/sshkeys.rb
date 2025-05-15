FactoryBot.define do
  factory :sshkey do
    name { "MyString" }
    private_key { "MyString" }
    iv { "MyString" }
    public_key { "MyString" }
    notes { "MyString" }
    user { nil }
  end
end
