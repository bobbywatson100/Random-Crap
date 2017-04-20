

directory = Dir.pwd + "/SI_DG_GL_*.dat"
Dir.glob(directory) do |item|

	# Open each file
	variantTableFile = File.open(item, "rb:BOM|UTF-16LE")
	variantTableFile.each_with_index do |line, index|
	
		line = line.encode("UTF-8").chomp
	
		if  (line.include? "ATRP" or line.include? "MDEOS" or line.include? "OMCTS" or line.include? "TEB" or line.include? "TEOS" or line.include? "TMOS" or line.include? "ALPHEUS" or line.include? "AMAT_1")
			puts item
			break
		end

	end # variantTableFile = File.readlines(item).each do |line, index|
	variantTableFile.close
end # Dir.glob(directory) do |item|
