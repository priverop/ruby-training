# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/word_frequency_analyzer'

RSpec.describe WordFrequencyAnalizer do
  let(:analyzer) { described_class.new("The quick brown fox jumps over the lazy dog. The dog barks!")}

  describe "#word_count" do
    context "when giving a proper string" do
      it "returns word count" do
        expect(analyzer.word_count).to eq(12)
      end
    end
  end
  
  describe "#unique_word_count" do
    context "when giving a proper string" do
      it "returns word count without duplicates" do
        expect(analyzer.unique_word_count).to eq(9)
      end
    end
  end

  describe "#frecuencies" do
    context "when giving a proper string" do
      it "returns a hash with the frecuencies" do
        expect(analyzer.frequencies).to include(
          "the" => 3,
          "dog" => 2,
          "quick" => 1
        )
      end
    end
  end

  describe "#most_common" do
    context "when giving a proper string" do
      it "returns an array with the most common words and freq" do
        expect(analyzer.most_common(2)).to eq([["the", 3], ["dog", 2]])
      end
    end
  end

  describe "#top_word" do
    context "when giving a proper string" do
      it "returns the most comon word" do
        expect(analyzer.top_word).to eq("the")
      end
    end

    context "when giving an empty string" do
      it "returns nil" do
        analyzer = described_class.new("")
        expect(analyzer.top_word).to be_nil
      end
    end
  end

  describe "#contains?" do
    context "when giving a proper string" do
      it "returns true" do
        expect(analyzer.contains?("FOX")).to be true
      end
    end
  end
end