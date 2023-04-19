require 'spec_helper'

RSpec.describe Xrechnung::Delivery do
  describe '#to_xml' do
    context 'with only a party name' do
      it 'has only the party name' do
        delivery = described_class.new party_name: 'ACME inc.'

        expect(to_xml(delivery)).to eq <<~XML
          <cac:Delivery>
            <cac:DeliveryParty>
              <cac:PartyName>
                <cbc:Name>ACME inc.</cbc:Name>
              </cac:PartyName>
            </cac:DeliveryParty>
          </cac:Delivery>
        XML
      end
    end

    context 'without any attributes' do
      it 'is nil' do
        delivery = described_class.new

        expect(to_xml(delivery)).to be_nil
      end
    end
  end
end
