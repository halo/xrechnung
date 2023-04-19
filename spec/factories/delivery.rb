FactoryBot.define do
  factory :delivery, class: 'Xrechnung::Delivery' do
    address factory: :postal_address

    actual_delivery_date { [nil, Date.today, Date.today - 1].sample }
    party_name { [nil, Faker::Company.name].sample }
  end
end
