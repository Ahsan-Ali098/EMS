# frozen_string_literal: true

# discount model file
class Discount < ApplicationRecord
  has_many :products
end
