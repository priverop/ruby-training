# Word Frequency Analyzer

Build a Ruby class `WordFrequencyAnalyzer` that analyzes a piece of text and 
provides statistics about word usage.

## API

```ruby
analyzer = WordFrequencyAnalyzer.new("The quick brown fox jumps over the lazy dog. The dog barks!")

analyzer.word_count        # => 12
analyzer.unique_word_count # => 9
analyzer.frequencies       # => { "the" => 3, "dog" => 2, "quick" => 1, ... }
analyzer.most_common(2)    # => [["the", 3], ["dog", 2]]
analyzer.top_word          # => "the"
analyzer.contains?("FOX")  # => true
```

## Rules

- Word matching is **case-insensitive**: "The" and "the" are the same word.
- **Punctuation must be stripped**: "dog." and "dog" are the same word, "barks!" is "barks".
- Words are separated by **whitespace** (spaces, tabs, newlines).
- An **empty or whitespace-only string** should return sensible defaults 
  (0 counts, empty hash, empty array, nil for `top_word`).
- `most_common(n)` returns the top `n` words sorted by frequency descending. 
  Ties can be broken however you want, but be consistent.
- `contains?` is also case-insensitive.

## Bonus (if time allows)
- `most_common(n)` should break ties **alphabetically**.
- Add a `stop_words` option to the constructor to ignore common words 
  ("the", "a", "and", etc.) from all stats.
- Handle contractions: "don't" should stay as "don't", not become "don" and "t".