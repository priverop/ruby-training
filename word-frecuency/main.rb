# frozen_string_literal: true

require 'bundler/setup'
require_relative 'lib/word_frecuency_analyzer'

analyzer = WordFrequencyAnalyzer.new("The quick brown fox jumps over the lazy dog. The dog barks!")

p analyzer.word_count        # => 11
p analyzer.unique_word_count # => 9
p analyzer.frequencies       # => { "the" => 3, "dog" => 2, "quick" => 1, ... }
p analyzer.most_common(2)    # => [["the", 3], ["dog", 2]]
p analyzer.top_word          # => "the"
p analyzer.contains?("FOX")  # => true