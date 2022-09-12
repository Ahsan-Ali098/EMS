# frozen_string_literal: true

require 'csv'
module ExportService
  # class UserExport
  class UserExport
    def initialize(data)
      @data = data
    end

    def to_csv
      attributes = %w[id user_name email confirmed_at]
      CSV.generate(headers: true) do |csv|
        csv << attributes
        @data.all.each do |user|
          csv << attributes.map { |attr| user.send(attr) }
        end
      end
    end
  end
end
