# frozen_string_literal: true

# Analyzes a piece of text and provides statistics about word usage.
class WordFrequencyAnalizer
  def initialize(text)
    @text = text
  end

  def word_count
    words.count
  end

  def unique_word_count
    words.uniq.count
  end

  def frequencies
    words.tally
  end

  def most_common(element_number)
    frequencies.sort_by{ |element| -element[1] }[0...element_number]
  end

  def top_word
    most_common(1).first.first unless most_common(1).empty?
  end

  def contains?(word)
    words.include?(word.downcase)
  end

  private

  def words
    @words ||= clean_string.downcase.split
  end

  def clean_string
    @text.gsub(".", "").gsub("!", "")
  end
end
