# frozen_string_literal: true

# Discount Controller
module Admin
  # Class for DiscountsController
  class DiscountsController < ApplicationController
    before_action :set_discount, only: %i[show update edit destroy]
    helper_method :sort_column, :sort_direction

    def index
      result = AdminDiscountIndex.call(
        per_page: params[:page],
        search_param: params[:search],
        sort: params[:sort],
        direction: params[:direction]
      )
      @discounts = result.discounts
      respond_to do |format|
        format.html
        format.csv {generate_csv}
      end
    end

    def new
      @discount = Discount.new
    end

    def create
      @discount = Discount.new(discount_params)
      ActiveRecord::Base.transaction do
        @discount.save!
        @discount.discount_for_products(params[:discount][:products])
        redirect_to admin_discounts_path, notice: 'Disocunt is saved. '
      rescue StandardError
        render 'new'
      end
    end

    def show; end

    def update
      if @discount.update(discount_params)
        redirect_to admin_dicounts_path
      else
        render 'edit'
      end
    end

    def edit; end

    def destroy
      @discount.destroy
      redirect_to admin_discounts_path
    end

    private

    def set_discount
      @discount = Discount.find(params[:id])
    end

    def generate_csv
      send_data ExportService::DiscountExport.new(Discount.all).to_csv, filename: "discountsinfo-#{Date.today}.csv"
    end

    def discount_params
      params.require(:discount).permit(:name, :price, :products_id)
    end

    def sort_column
      Discount.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  end
end
