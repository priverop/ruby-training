# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/vending_machine'

# TODO: add before for coins

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new(
      inventory: [
        Product.new(name: 'chips', price: 120, quantity: 12),
        Product.new(name: 'soda', price: 80, quantity: 9),
        Product.new(name: 'chocolate', price: 200, quantity: 4)
      ]
    )
  end

  describe '#insert_coin' do
    context 'when passing a valid coin' do
      it 'returns true' do
        expect(machine.insert_coin(100)).to be true
      end

      it 'increases the total_amount of the machine' do
        machine.insert_coin(100)
        expect(machine.total_amount).to eq(100)
      end
    end

    context 'when passing a not valid coin' do
      it 'raises CoinValueNotSupportedException' do
        expect { machine.insert_coin(0) }.to raise_error(VendingMachine::CoinValueNotSupportedException, "Coin value '0' not supported.")
      end
    end

    # TODO: when passing not an integer
  end

  describe '#select_product' do
    context 'when the name is valid, has stock, and exact amount inserted' do
      it 'dispenses the product and no change' do
        machine.insert_coin(100)
        machine.insert_coin(20)

        result = machine.select_product('chips')
        expect(result).to eq({ product: 'chips', change: [], status: :success })
      end

      it 'decreases the machine total amount' do
        machine.insert_coin(100)
        machine.insert_coin(20)

        machine.select_product('chips')
        expect(machine.total_amount).to eq(0)
      end
    end

    context 'when there is no product with such name' do
      it 'raises ProductErrorException' do
        machine.insert_coin(100)
        machine.insert_coin(20)

        expect do
          machine.select_product('c')
        end.to raise_error(VendingMachine::ProductErrorException, "product 'c' not found.")
      end
    end

    context 'when there is no stock for the valid product name' do
      let(:no_stock_machine) do
        described_class.new(
          inventory: [
            Product.new(name: 'chips', price: 120, quantity: 0)
          ]
        )
      end

      it 'returns a hash with change and error message' do
        no_stock_machine.insert_coin(100)
        no_stock_machine.insert_coin(20)
        expect(no_stock_machine.select_product('chips')).to eq({ change: [100, 20], message: "product 'chips' is out of stock.", status: :out_of_stock })
      end
    end

    context 'when the same product is selected until the stock is out' do
      let(:no_stock_machine) do
        described_class.new(
          inventory: [
            Product.new(name: 'chips', price: 120, quantity: 2)
          ]
        )
      end

      before do
        no_stock_machine.insert_coin(100)
        no_stock_machine.insert_coin(20)
        no_stock_machine.select_product('chips')
        no_stock_machine.insert_coin(100)
        no_stock_machine.insert_coin(20)
        no_stock_machine.select_product('chips')
      end

      it 'returns the coins and out_of_stock status' do
        no_stock_machine.insert_coin(100)
        no_stock_machine.insert_coin(20)
        expect(no_stock_machine.select_product('chips')).to eq({ change: [100, 20], message: "product 'chips' is out of stock.", status: :out_of_stock })
      end
    end

    context 'when the machine has no coins' do
      it 'returns empty change and error message' do
        expect(machine.select_product('chips')).to eq({ change: [], message: 'not enough funds.', status: :insufficient_funds })
      end
    end

    context 'when the machine has not enough coins for the product' do
      it 'returns change and error message' do
        machine.insert_coin(100)
        expect(machine.select_product('chips')).to eq({ change: [100], message: 'not enough funds.', status: :insufficient_funds })
      end
    end
  end

  describe '#cancel' do
    context 'when the machine has coins' do
      before do
        machine.insert_coin(200)
        machine.insert_coin(50)
        machine.insert_coin(20)
        machine.insert_coin(20)
        machine.insert_coin(20)
        machine.insert_coin(20)
        machine.insert_coin(10)
        machine.insert_coin(5)
      end

      it 'returns all the coins' do
        expect(machine.cancel).to eq({ change: [200, 100, 20, 20, 5], status: :cancelled })
      end

      it 'empties the machine coins' do
        machine.insert_coin(100)
        machine.cancel
        expect(machine.total_amount).to eq(0)
      end
    end

    context 'when the machine has no coins' do
      it 'returns empty change' do
        expect(machine.cancel).to eq({ change: [], status: :cancelled })
      end
    end
  end
end
