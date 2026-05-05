# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/calendar'

RSpec.describe Calendar do
	let(:calendar) { described_class.new }

	describe '#header' do
		context 'when there is no input' do
			it 'returns the month and year' do
				# This will fail nextt month.
				expect(calendar.header).to eq('     April 2026     ')
			end
		end
	end

	describe '#week_days' do
		context 'when there is no input' do
			it 'returns the week days' do
				expect(calendar.week_days).to eq('Su Mo Tu We Th Fr Sa')
			end
		end
	end

	describe '#days' do
		it 'returns the whole calendar days' do
			days = 
<<-TEXT
          1  2  3  4 
 5  6  7  8  9 10 11 
12 13 14 15 16 17 18 
19 20 21 22 23 24 25 
26 27 28 29 30
TEXT
			expect(calendar.days).to eq(days)
		end
	end

	describe '#full' do
		it 'returns the full calendar' do
						full_calendar = 
<<-TEXT
     April 2026     
Su Mo Tu We Th Fr Sa
          1  2  3  4 
 5  6  7  8  9 10 11 
12 13 14 15 16 17 18 
19 20 21 22 23 24 25 
26 27 28 29 30
TEXT

			expect(calendar.full).to eq(full_calendar)
		end
	end
end