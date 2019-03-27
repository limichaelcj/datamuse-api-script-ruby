require 'rest-client'
require 'json'
require 'yaml'

OUTPUT_FILE = begin
  YAML.load_file(File.join(__dir__, 'config.yml')).fetch('output_file')
rescue Errno::ENOENT, KeyError
  '.'
end

puts OUTPUT_FILE

def program_abort
  puts "Error: Please refer to readme for proper usage."
  abort
end

program_abort unless ARGV.length > 1

# data validation
args = ARGV
args.pop if args.length % 2 != 0

# setting up api endpoint
parameters = args.select.with_index do |val, index|
  index % 2 == 0
end
values = args.select.with_index do |val, index|
  index % 2 != 0
end

URL = 'https://api.datamuse.com/words'

queries = []

def build_query(query, keyword)
  case query
  when 'related'
    return "ml=#{keyword}"
  when 'synonym', 'syn'
    return "rel_syn=#{keyword}"
  when 'antonym', 'ant'
    return "rel_ant=#{keyword}"
  when 'sound'
    return "sl=#{keyword}"
  when 'describe'
    return "rel_jjb=#{keyword}"
  when 'describe_by'
    return "rel_jja=#{keyword}"
  when 'rhyme'
    return "rel_rhy=#{keyword}"
  when 'max'
    return "max=#{keyword}"
  when 'prefix'
    return "sp=#{keyword}*"
  when 'suffix'
    return "sp=*#{keyword}"
  when 'spelling', 'spell'
    return "sp=#{keyword}"
  when 'follow'
    return "rel_bga=#{keyword}"
  when 'precede'
    return "rel_bgb=#{keyword}"
  when 'general', 'parent'
    return "rel_gen=#{keyword}"
  when 'specific', 'kind', 'kind_of'
    return "rel_spc=#{keyword}"
  when 'comprise'
    return "rel_com=#{keyword}"
  when 'part_of', 'part'
    return "rel_par=#{keyword}"
  when 'sort', 'topic'
    return "topics=#{keyword}"
  when 'trigger', 'associated'
    return "rel_trg=#{keyword}"
  when 'homophone'
    return "rel_hom=#{keyword}"
  else
    return ""
  end
end

parameters.each_with_index do |param, index|
  queries.push build_query(param, values[index])
end

queryString = queries.join('&')
program_abort if queryString == ''

endpoint = "#{URL}?#{queryString}"

# API call
print "Fetching #{endpoint}..."
response = RestClient.get endpoint
json = JSON.parse(response.body)
puts "Done"

data = json.map { |entry| entry["word"] }

# write data
filepath = "#{Dir.pwd}/#{OUTPUT_FILE}"
print "Writing data to #{filepath}..."
File.open(filepath, 'w') do |file|
  file.puts "[\n"
  data.each do |word|
    file.puts "  \"#{word}\",\n"
  end
  file.puts "]"
end
puts "Done"
