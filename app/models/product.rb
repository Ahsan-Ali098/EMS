# frozen_string_literal: true

class Product < ApplicationRecord
  enum status: %i[publish draft pending]
end
