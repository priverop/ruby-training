# frozen_string_literal: true

# Given a spreadsheet column, get the index (number):
# A = 1
# B = 2
# Z = 26
# AA = 27
# AB = 28
# ...
class Excel
  def self.index(column)
    return encode(column) if column.size == 1

    (index(column[0...-1]) * 26) + index(column.chars.last)
  end

  def self.encode(letter)
    letter.ord - 64
  end
end
