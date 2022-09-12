# frozen_string_literal: true

class Product < ApplicationRecord
  paginates_per 5
  belongs_to :category
  enum status: %i[publish draft pending]
end
