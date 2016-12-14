require 'optparse'

option={}
OptionParser.new do |opt|
	#例（eg.）
	# opt.on('-a',         '1文字オプション 引数なし')         {|v| option[:a] = v}
	# opt.on('-b VALUE',   '1文字オプション 引数あり（必須）')   {|v| option[:b] = v}
	# opt.on('-c [VALUE]', '1文字オプション 引数あり（省略可能）'){|v| option[:c] = v}
	opt.on( "-c", "--CompareFolder", "It's flag for compare to tow folders",
			"true:??? false:???" ) do |v|
		option[:c] = v
	end
	opt.parse!(ARGV)
end

if option[:c]
	firstDir = nil
	secendDir = nil
	loop {
		if firstDir == nil
			puts '一つ目のフォルダを入力してください。終了したい場合exitを入力してください'
			str = gets.chomp
			firstDir = str
			
			# loop 抜け方法
			if str.upcase == 'EXIT'
				break
			end

			next
		end

		if secendDir == nil
			puts '二つ目のフォルダを入力してください。終了したい場合exitを入力してください'
			str = gets.chomp
			secendDir = str

			# loop 抜け方法
			if str.upcase == 'EXIT'
				break
			end

			next
		end

		if firstDir != nil && secendDir != nil
			# folder compare processing

			firstDir = nil
			secendDir = nil
			next
		end
	}
end