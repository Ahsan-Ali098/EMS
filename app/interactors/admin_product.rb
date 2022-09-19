class AdminProduct < ApplicationInteractor
  delegate :per_page, :search_param, :sort, :direction, :search, to: :context
  delegate :products, to: :context

  def call
    search(search_param, per_page)
  end

  private

  def search(search_param, per_page)
    context.products = if search_param.present?
                  Product.search_product(search_param)
                    .page(per_page)
                else
                  Product.all.page(per_page).order(sort_param)
                end
    context.products.page(per_page)
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
