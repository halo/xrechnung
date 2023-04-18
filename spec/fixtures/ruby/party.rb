load("spec/fixtures/ruby/party_tax_scheme.rb")
load("spec/fixtures/ruby/party_legal_entity.rb")
load("spec/fixtures/ruby/contact.rb")

def build_party
  Xrechnung::Party.new(
    postal_address:     build(:postal_address, :predictable),
    party_tax_scheme:   build_party_tax_scheme,
    party_legal_entity: build_party_legal_entity,
    contact:            build_contact,
  )
end
