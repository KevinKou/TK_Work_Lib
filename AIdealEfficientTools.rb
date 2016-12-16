require 'optparse'
require 'fileutils'
require 'find'

option={}
OptionParser.new do |opt|
	#例（eg.）
	# opt.on('-a',         '1文字オプション 引数なし')				{|v| option[:a] = v}
	# opt.on('-b VALUE',   '1文字オプション 引数あり（必須）')		{|v| option[:b] = v}
	# opt.on('-c [VALUE]', '1文字オプション 引数あり（省略可能）')	{|v| option[:c] = v}
	opt.on( "-c", "--CompareFolder", "It's flag for compare to tow folders",
			"true:??? false:???" ) do |v|
		option[:c] = v
	end
	opt.parse!(ARGV)
end

def DeleteSymbol_Of_CurrentDir(filePath)
	return filePath[1..filePath.size]
end

def CompareFolderForAIdeal(src, dest)

	srcAbsPath = File::expand_path(src)
	destAbsPath = File::expand_path(dest)
	
	Dir.chdir srcAbsPath
	srcFiles = Dir.glob("./**/*")

	Dir.chdir destAbsPath
	destFiles = Dir.glob("./**/*")

	# src にあってDestにないもの
	fileExistIn_Src = (srcFiles - destFiles)
	if fileExistIn_Src != nil
		fileExistIn_Src.each { 
			|file|
			filePath = srcAbsPath.to_s + DeleteSymbol_Of_CurrentDir(file).to_s
			fileModifyTime = File::stat(filePath).mtime.to_s
			puts "#{filePath}, #{fileModifyTime}"
		}
	end

	# dest にあってsrcにないもの
	fileExistIn_Dest = (destFiles - srcFiles)
	if fileExistIn_Dest != nil
		fileExistIn_Dest.each { 
			|file|
			p DeleteSymbol_Of_CurrentDir(file).to_s
			p destAbsPath.to_s
			filePath = destAbsPath.to_s + DeleteSymbol_Of_CurrentDir(file).to_s
			fileModifyTime = File::stat(filePath).mtime.to_s
			puts "#{filePath}, #{fileModifyTime}"
		}
	end

	# 二つともにあるもの
	fileBothExist = (srcFiles & destFiles)
	if fileBothExist != nil
		fileBothExist.each {
			|file|
			filePath_src = srcAbsPath.to_s + DeleteSymbol_Of_CurrentDir(file).to_s
			filePath_dest = destAbsPath.to_s + DeleteSymbol_Of_CurrentDir(file).to_s

			fileModifyTime_src = File::stat(filePath_src).mtime.to_s
			fileModifyTime_dest = File::stat(filePath_dest).mtime.to_s

			if fileModifyTime_src != fileModifyTime_dest
				puts "#{file}異なる:"
				puts "  #{filePath_src}, #{fileModifyTime_src}"
				puts "  #{filePath_dest}, #{fileModifyTime_dest}"
			end
		}
	end
end

# 指定した両フォルダに:
#  1. お互いにないファイルを出力する
#  2. お互いにあるファイルで、更新日が違いものを出力する
if option[:c]
	srcDir = nil
	destDir = nil
	loop {
		if srcDir == nil
			puts '一つ目のフォルダを入力してください。終了したい場合exitを入力してください'
			str = gets.chomp
			srcDir = str
			
			# loop 抜け方法
			if str.upcase == 'EXIT'
				break
			end

			next
		end

		if destDir == nil
			puts '二つ目のフォルダを入力してください。終了したい場合exitを入力してください'
			str = gets.chomp
			destDir = str

			# loop 抜け方法
			if str.upcase == 'EXIT'
				break
			end

			next
		end

		if srcDir != nil && destDir != nil
			# folder compare processing
			CompareFolderForAIdeal(srcDir, destDir)

			srcDir = nil
			destDir = nil
			next
		end
	}
end




