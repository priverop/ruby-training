# frozen_string_literal: true

require_relative 'coin_values'
require_relative 'product'

# Vending Machine main class. State: inventory and total_amount.
# Inventory: Array of Products.
# Total_amount: Int, sum of the value of all the inserted coins. Default: 0
class VendingMachine
  class CoinValueNotSupportedException < StandardError; end
  class NoStockException < StandardError; end
  class ProductErrorException < StandardError; end

  attr_reader :total_amount

  def initialize(inventory:, total_amount: 0)
    @inventory = inventory
    @total_amount = total_amount
  end

  def insert_coin(coin_value) # rubocop:disable Naming/PredicateMethod
    unless coin_value.is_a?(Integer) && CoinValues::COIN_VALUES.include?(coin_value)
      raise CoinValueNotSupportedException, "Coin value '#{coin_value}' not supported."
    end

    @total_amount += coin_value
    true
  end

  def select_product(name)
    product = @inventory.find { |product| product.name == name }

    raise ProductErrorException, "product '#{name}' not found." unless product
    return out_of_stock(name) unless product.quantity.positive?

    return insufficient_funds if @total_amount < product.price

    product.quantity -= 1
    @total_amount -= product.price

    dispense_product(product)
  end

  def cancel
    dispense(status: :cancelled)
  end

  private

  def reset_total_amount
    @total_amount = 0
  end

  def change
    return [] if @total_amount.zero?

    index = CoinValues::COIN_VALUES.count - 1
    current_amount = @total_amount
    calculate_change([], current_amount, index)
  end

  def calculate_change(change, current_amount, index)
    while index >= 0
      coin_value = CoinValues::COIN_VALUES[index]

      if current_amount >= coin_value
        change << coin_value
        current_amount -= coin_value
      else
        index -= 1
      end
    end
    change
  end

  def out_of_stock(name)
    dispense(message: "product '#{name}' is out of stock.", status: :out_of_stock)
  end

  def insufficient_funds
    dispense(message: 'not enough funds.', status: :insufficient_funds)
  end

  def dispense_product(product)
    dispense(product: product.name, status: :success)
  end

  def dispense(status:, **extra)
    change_for_user = change
    reset_total_amount

    { change: change_for_user, status:, **extra }
  end
end
