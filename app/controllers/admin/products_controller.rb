# frozen_string_literal: true

# Product Controller
module Admin
  # Class for ProductsController
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[show update edit destroy]
    helper_method :sort_column, :sort_direction

    def index
      per_page = params[:page]
      search_param = params[:search]
      search(search_param, per_page)
      respond_to do |format|
        format.html
        format.csv do
          send_data ExportService::ProductExport.new(Product.all).to_csv, filename: "productsinfo-#{Date.today}.csv"
        end
      end
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path
      else
        render 'new'
      end
    end

    def show; end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render 'edit'
      end
    end

    def edit; end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private

    def sort_param
      "#{sort_column} #{sort_direction}"
    end

    def search(search_param, per_page)
      @products = if search_param.present?
                    Product.search_product(search_param)
                           .page(per_page)
                  else
                    Product.all.page(per_page).order(sort_param)
                  end
      @products.page(per_page)
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :title,
        :price,
        :description,
        :status,
        :category_id,
        :image
      )
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  end
end
