module Xrechnung
  class PartyLegalEntity
    include MemberContainer

    # @!attribute registration_name
    #   @return [String]
    member :registration_name, type: String

    # Seller legal registration infomation BT-30
    #
    # Ein von einer offiziellen Regi-strierungsstelle ausgegebene Kennung,
    # der den Verkäufer als Rechtsträger oder juristische Person identifiziert
    # Handelsregistereintrag
    #
    # @!attribute company_id
    #   @return [String]
    member :company_id, type: String

    # Seller additional legal infomation BT-33
    #
    # Weitere rechtliche Informationen, die für den Verkäufer maßgeblich sind.
    # Wie z. B. Aktienkapital oder der Grund, wieso keine Umsatzsteuer
    # ausgewiesen wird im Falle von Kleinunternehmern
    #
    # @!attribute additional_legal_information
    #   @return [String]
    member :additional_legal_information, type: String

    # noinspection RubyResolve
    def to_xml(xml)
      xml.cac :PartyLegalEntity do
        xml.cbc :RegistrationName, registration_name
        xml.cbc :CompanyID, company_id
        xml.cbc :CompanyLegalForm, additional_legal_information if additional_legal_information
      end
    end
  end
end
