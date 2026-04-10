# frozen_string_literal: true

class Fibonacci
  def self.calculate_iterative(max_iterations)
    result = 0
    prev = 0
    actual = 1
    for i in 1..max_iterations do
      # next if i == 0
      result += actual
      aux = prev + actual
      prev = actual

      actual = aux
    end
    return result
  end

  def self.calcule_recursive(max)
    return max if max <= 1

    calcule_recursive(max - 1) + calcule_recursive(max - 2)
  end
end
