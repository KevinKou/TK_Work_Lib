require 'csv'
require 'optparse'
require 'time'

options = {}
option_parser = OptionParser.new do
	|opts|
	opts.on('-S Start Time','Input time like as YYYY/MM/DD/HH/MM') {
		|value|
		options[:Start] = value
	}

	opts.on('-P Stop Time','Input time like as YYYY/MM/DD/HH/MM') {
		|value|
		options[:Stop] = value
	}

end.parse!

# puts options[:Start]
# puts options[:Stop]

start_YY = options[:Start].split('/')[0]
start_MM = options[:Start].split('/')[1]
start_DD = options[:Start].split('/')[2]
start_HH = options[:Start].split('/')[3]
start_mm = options[:Start].split('/')[4]

stop_YY = options[:Stop].split('/')[0]
stop_MM = options[:Stop].split('/')[1]
stop_DD = options[:Stop].split('/')[2]
stop_HH = options[:Stop].split('/')[3]
stop_mm = options[:Stop].split('/')[4]

start = Time.local(start_YY, start_MM, start_DD, start_HH, start_mm)
stop = Time.local(stop_YY, stop_MM, stop_DD, stop_HH, stop_mm)

days = (stop - start).divmod(24*60*60)
hours = days[1].divmod(60*60)
mins = hours[1].divmod(60)
puts "経過時間：#{days[0]}日#{hours[0]}時間#{mins[0]}分#{mins[1]}秒"
