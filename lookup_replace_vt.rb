# Get the name of the source table
fileName = Dir.pwd + "/gas_pallets.dat"

# Open the file
lookupFile = File.open(fileName, "rb:BOM|UTF-16LE")

# Create the hash for the value lookup
valuesHash = Hash.new()

# Convert the file (format is old_value \t new_value) into a hash
while (line = lookupFile.gets)
	if line != nil
		values = line.encode("UTF-8").chomp.split("\t")
		if values.count > 0
			valuesHash[values[0]] = values[1]
		end
	end
end

lookupFile.close

directory = Dir.pwd + "/SI_DG_GL_*.dat"
Dir.glob(directory) do |item|

	outputArray = Array.new()
	
	puts "Processing #{item}"

# Open each file
	variantTableFile = File.open(item, "rb:BOM|UTF-16LE")
	variantTableFile.each_with_index do |line, index|
	
# Each line of the variant table files should have four fields:
#   Table name	\t	Line number	\t	gas pallet ID	\t	gas
# For each line, replace the gas pallet ID with the new ID from the has table

# Not sure how to work with Unicode 16, so convert to UTF-8 for simplicity
		line = line.encode("UTF-8").chomp

# If the current line is the first one, don't do anything and just add it to the output File
		if index == 0
			outputArray.push(line)
		else
		
# ignore if line is empty -- does not work, not sure why, doesn't really matter
	if line.chomp.empty?
		puts "Empty string at line #{index}"
		next
	end

	# Split the line into an array and make sure it has four elements
			values = line.split("\t")
			
			if values.count == 4
			
# Lookup the new value for the gas pallet (third value)
				valueToLookup = values[2]
				values[2] = valuesHash[valueToLookup]
				
# Append the new line to the outputFile
				newLine = "#{values[0]}\t#{values[1]}\t#{values[2]}\t#{values[3]}".to_s
				outputArray.push(newLine)
			else
				puts "line #{index} does not have 4 elements and will be skipped" 
			end #values.count != 4
			
		end # index == 0

# Output the updated content to the file
	newFileName = File.dirname(item) + "\\output\\" + File.basename(item)
	outputFile = File.open(newFileName, "wt", encoding:"UTF-16LE")

	outputArray.each_with_index do |line, index|
		if index == 0  # Add BOM at the beginning of the file
			outputFile.puts "\uFEFF".encode("UTF-16LE") + line.encode("UTF-16LE")
		else
			outputFile.puts line.encode("UTF-16LE")
		end
	end

	outputFile.close
	end # variantTableFile = File.readlines(item).each do |line, index|
end # Dir.glob(directory) do |item|
