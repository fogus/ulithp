require 'reader'

puts "Compiling: #{ARGV[0]}"

filename = ARGV[0]
source = File.open(filename, "r").read

reader = Reader.new(source)
forms = []

while((form = reader.read) != :"no more forms")
  forms << form
end

compiled_forms = Marshal.dump(forms)
outfile = filename.gsub /lisp/, 'ulithp'

puts "Writing #{forms.size} forms to #{outfile}"

File.open(outfile, 'w') { |f| f.write(compiled_forms) }
