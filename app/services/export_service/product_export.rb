# frozen_string_literal: true

require 'csv'
module ExportService
  # class ProductExport
  class ProductExport
    def initialize(data)
      @data = data
    end

    def to_csv
      CSV.generate do |csv|
        csv << %w[Id title Price Description Category Status]
        @data.each do |product|
          csv << [product.id, product.id, product.price, product.description, product.category.name, product.status]
        end
      end
    end
  end
end
