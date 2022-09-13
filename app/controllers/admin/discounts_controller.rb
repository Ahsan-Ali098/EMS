# frozen_string_literal: true

# Discount Controller
module Admin
  # Class for DiscountsController
  class DiscountsController < ApplicationController
    before_action :set_discount, only: %i[show update edit destroy]
    helper_method :sort_column, :sort_direction

    def index
      per_page = params[:page]
      search_param = params[:search]
      search(search_param, per_page)
      respond_to do |format|
        format.html
        format.csv do
          send_data ExportService::DiscountExport.new(Discount.all).to_csv, filename: "discountsinfo-#{Date.today}.csv"
        end
      end
    end

    def sort_param
      "#{sort_column} #{sort_direction}"
    end

    def new
      @discount = Discount.new
    end

    def create
      @discount = Discount.new(discount_params)
      if @discount.save
        redirect_to admin_discounts_path
      else
        render 'new'
      end
    end

    def show; end

    def update
      if @discount.update(discount_params)
        redirect_to admin_discounts_path
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

    def search(search_param, per_page)
      @discounts = if search_param.present?
                     Discount.search(search_param)
                             .page(per_page)
                   else
                     Discount.all.page(per_page).order(sort_param)
                   end
      @discounts.page(per_page)
    end

    def set_discount
      @discount = Discount.find(params[:id])
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
