require "csv"
require "yaml"

if ARGV.length < 1
  puts <<-HELP

This will generate a const/title list for use in the params schema from instances.csv.

A node type is required.

Examples:

ruby hack/instances.rb data
ruby hack/instances.rb master
ruby hack/instances.rb warm
ruby hack/instances.rb data ebs # to filter by ebs only
ruby hack/instances.rb data ssd # to filter by ssd only
HELP
  exit 1
end

type = ARGV[0]
subtype = ARGV[1]


$supported_instance_classes = {
  # Filter out t2/3 classes and only use current generate
  "data" => ['c5', 'c6g', 'i3', 'm5', 'm6g', 'r5', 'r6gd'],
  # Dont generate master, we pick these automatically
  "master" => [],
  "warm" => ['ultrawarm1']
}

$supported_instance_class = $supported_instance_classes[type]

file = File.read("#{__dir__}/instances.csv")
table = CSV.parse(file, headers: true)

options = []

sorted = table.sort_by{|entry|
  memory = entry["Memory"].split(" ").first.to_f
  cpus = entry["vCPUs"].split(" ").first.to_f
  [memory, cpus]
}

sorted.each do |entry|

  name = entry["Name"]
  cpus = entry["vCPUs"]
  memory = entry["Memory"]
  storage = entry["Storage"]

  instance_class = entry["API Name"].split(".").first
  next if !$supported_instance_class.include?(instance_class)

  if subtype
    if subtype.downcase == "ebs" && storage != "EBS Only"
      next
    end

    if subtype.downcase == "ssd" && storage !~ /SSD/
      next
    end
  end

  options << {
    "title" => "#{name} (#{cpus}, #{memory} RAM)",
    "const" => entry["API Name"] # instance name
  }
end

puts options.to_yaml({:line_width => -1})
