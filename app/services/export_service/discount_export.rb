# frozen_string_literal: true

require 'csv'
module ExportService
  # class UserExport
  class DiscountExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[id name price]
      CSV.generate(headers: true) do |csv|
        csv << attributes
        @data.each do |user|
          csv << attributes.map { |attr| user.send(attr) }
        end
      end
    end
  end
end
