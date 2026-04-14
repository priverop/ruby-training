# frozen_string_literal: true

require_relative 'coin_values'
require_relative 'product'

# Vending Machine main class. State: inventory and total_amount.
# Inventory: Array of Products.
# Total_amount: Int, sum of the value of all the inserted coins. Default: 0
class VendingMachine
  class InsufficientFundsException < StandardError; end
  class NoStockException < StandardError; end
  class ProductErrorException < StandardError; end

  attr_reader :total_amount

  def initialize(inventory:, total_amount: 0)
    @inventory = inventory
    @total_amount = total_amount
  end

  def insert_coin(coin_value) # rubocop:disable Naming/PredicateMethod
    return false unless CoinValues::COIN_VALUES.include?(coin_value) # TODO: exception?

    @total_amount += coin_value
    true
  end

  def select_product(name)
    raise InsufficientFundsException, 'machine has no funds, please insert coins' unless @total_amount.positive?

    product = @inventory.find { |product| product.name == name }

    raise ProductErrorException, "product '#{name}' not found." unless product
    raise NoStockException, "product '#{name}' is out of stock." unless product.quantity.positive?

    product.quantity -= 1

    raise InsufficientFundsException, "not enough founds, please insert #{product.price - @total_amount} more." if @total_amount < product.price

    @total_amount -= product.price

    { product: product.name, change: }
  end

  def cancel
    { change: }
  end

  private

  # TODO: algorithm for change
  def change
    return [] if @total_amount.zero?

    [@total_amount]
  end
end
