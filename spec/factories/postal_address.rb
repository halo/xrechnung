FactoryBot.define do
  factory :postal_address, class: 'Xrechnung::PostalAddress' do
    additional_street_name { [nil, Faker::Address.secondary_address].sample }
    city_name { Faker::Address.city }
    country_id { Faker::Address.country_code }
    country_subentity { [nil, Faker::Address.state_abbr].sample }
    postal_zone { Faker::Address.zip_code }
    street_name { [nil, Faker::Address.street_address].sample }

    # Technically this is not needed, but to make the transition easier we have this trait.
    trait :predictable do
      additional_street_name { 'Haus A' }
      city_name { 'Baustadt' }
      country_id { 'DE' }
      country_subentity { 'MusterBL' }
      postal_zone { '12345' }
      street_name { 'Beispielgasse 17' }
    end
  end
end
