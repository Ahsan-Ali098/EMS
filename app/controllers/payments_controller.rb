# frozen_string_literal: true

# Payments_controller
class PaymentsController < ApplicationController
  before_action :current_cart
  def create  # rubocop:disable Metrics/MethodLength
    order = Order.last
    product = Stripe::Product.create({ name: order.firstname })
    price = Stripe::Price.create({
                                   unit_amount: order.price.to_i,
                                   currency: 'usd',
                                   product: product.id,
                                 })
    @session =
      Stripe::Checkout::Session.create({
                                         payment_method_types: ['card'],
                                         line_items: [{
                                           price: price.id,
                                           quantity: 1,
                                         }],
                                         mode: 'payment',
                                         success_url: root_url,
                                         cancel_url: root_url,
                                       })
    respond_to { |format| format.js }
  end
end
