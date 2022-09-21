# frozen_string_literal: true

class AdminProduct < ApplicationInteractor
  delegate :per_page, :search_param, :sort, :direction, :search, to: :context

  def call
    search(search_param, per_page)
  end

  private

  def search(search_param, per_page)
    scope = Product
    scope = scope.search(search_param) if search_param.present?
    scope = scope.page(per_page).order(sort_param)
    context.products = scope
  end

  def sort_param
    "#{sort_column} #{sort_direction}"
  end

  def sort_column
    Product.column_names.include?(sort) ? sort : 'id'
  end

  def sort_direction
    %w[asc desc].include?(direction) ? direction : 'asc'
  end
end
