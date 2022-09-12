# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  enum status: %i[publish draft pending]
end
