require 'spec_helper'

RSpec.describe Xrechnung::PostalAddress do
  describe '#to_xml' do
    context 'without attributes' do
      it 'only contains mandatory attributes' do
        postal_address            = described_class.new
        postal_address.country_id = 'SE'

        expect(to_xml(postal_address)).to eq <<~XML
          <cac:PostalAddress>
            <cac:Country>
              <cbc:IdentificationCode>SE</cbc:IdentificationCode>
            </cac:Country>
          </cac:PostalAddress>
        XML
      end
    end

    context 'with all attributes' do
      it 'has all attributes' do
        postal_address = build(:postal_address, :predictable)

        expect(to_xml(postal_address)).to eq <<~XML
          <cac:PostalAddress>
            <cbc:StreetName>Beispielgasse 17</cbc:StreetName>
            <cbc:AdditionalStreetName>Haus A</cbc:AdditionalStreetName>
            <cbc:CityName>Baustadt</cbc:CityName>
            <cbc:PostalZone>12345</cbc:PostalZone>
            <cbc:CountrySubentity>MusterBL</cbc:CountrySubentity>
            <cac:Country>
              <cbc:IdentificationCode>DE</cbc:IdentificationCode>
            </cac:Country>
          </cac:PostalAddress>
        XML
      end
    end

    context 'with an optional attribute' do
      it 'does not include it for nil values' do
        postal_address = build(:postal_address, country_subentity: 'Bayern')

        expect(to_xml(postal_address)).to include '<cbc:CountrySubentity>Bayern</cbc:CountrySubentity>'

        postal_address.country_subentity = nil

        expect(to_xml(postal_address)).not_to include 'CountrySubentity'
      end
    end
  end
end
