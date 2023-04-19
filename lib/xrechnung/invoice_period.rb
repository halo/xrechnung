module Xrechnung
  # BG-14
  class InvoicePeriod
    include MemberContainer

    member :start_date, type: Date
    member :end_date, type: Date

    def to_xml(xml)
      return unless start_date || end_date

      xml.cac :InvoicePeriod do
        xml.cbc :StartDate, start_date if start_date
        xml.cbc :EndDate, end_date if end_date
      end
    end
  end
end
