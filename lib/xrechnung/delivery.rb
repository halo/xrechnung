module Xrechnung
  class Delivery
    include MemberContainer
    #
    # @!attribute actual_delivery_date
    #   @return [String]
    member :actual_delivery_date, type: Date

    # @!attribute party_name
    #   @return [String]
    member :party_name, type: String

    # @!attribute address
    #   @return [Xrechnung::PostalAddress]
    member :address, type: Xrechnung::PostalAddress

    # noinspection RubyResolve
    def to_xml(xml)
      return if actual_delivery_date.nil? && address.blank? && party_name.nil?

      xml.cac :Delivery do
        xml.cbc :ActualDeliveryDate, actual_delivery_date unless actual_delivery_date.nil?

        unless address.nil?
          xml.cac :DeliveryLocation do
            # This is like a `PostalAddress`, but is instead called `Address`.
            xml.cac :Address do
              xml.cbc :StreetName, address.street_name if address.street_name
              xml.cbc :AdditionalStreetName, address.additional_street_name if address.additional_street_name
              xml.cbc :CityName, address.city_name if address.city_name
              xml.cbc :PostalZone, address.postal_zone if address.postal_zone
              xml.cbc :CountrySubentity, address.country_subentity if address.country_subentity

              xml.cac :Country do
                xml.cbc :IdentificationCode, address.country_id if address.country_id
              end
            end
          end
        end

        unless party_name.nil?
          xml.cac :DeliveryParty do
            xml.cac :PartyName do
              xml.cbc :Name, party_name
            end
          end
        end
      end
    end
  end
end
