# frozen_string_literal: true

require 'date'

class Calendar

	def full
		"#{header}\n#{week_days}\n#{days}"
	end

	def header
		Date.today.strftime('%B %Y').center(20)
	end

	def week_days
		Date::ABBR_DAYNAMES.map do |day|
			day[0...-1]
		end.join(' ')
	end

	def days
		ending_day = days_in_month(Date.today.year, Date.today.month)
		first_wday = first_weekday(Date.today.year, Date.today.month)

		output = ''

		first_wday.times { |day| output += '   ' }

		(1..ending_day).each do |day|
			output += "#{day.to_s.rjust(2)}"
			output += ' ' unless day == ending_day
			output += "\n" if weekday_name(day) == 'Sat' || day == ending_day
		end

		output
	end

	private

	def days_in_month(year, month)
  	Date.new(year, month, -1).day
	end

	def weekday_name(day)
		Date::ABBR_DAYNAMES[Date.new(Date.today.year, Date.today.month, day).wday]
	end

	def first_weekday(year, month)
		Date.new(year, month, 1).wday
	end
end

calendar = Calendar.new
puts calendar.full
