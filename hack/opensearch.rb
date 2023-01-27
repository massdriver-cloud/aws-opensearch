require 'opensearch'
require 'faraday_middleware/aws_sigv4'
require 'faker'

$help = <<-USAGE
Generate and query data from OpenSearch

Usage:
  ruby opensearch.rb create-index
  ruby opensearch.rb add-document N
  ruby opensearch.rb search query

Expects the following env vars:
* OS_DOMAIN
* OS_USERNAME
* OS_PASSWORD

USAGE

task = ARGV[0]

if !task
  puts $help
  exit 1
end

client = OpenSearch::Client.new(hosts: [
  { host: ENV['OS_DOMAIN'],
    port: '443',
    user: ENV['OS_USERNAME'],
    password: ENV['OS_PASSWORD'],
    scheme: 'https'
  } ])

index_name = 'contacts'

if task == "create-index"
  index_body = {
    'settings': {
      'index': {
        'number_of_shards': 4
      }
    }
  }

  response = client.indices.create(
    index: index_name,
    body: index_body
  )

  puts 'Creating index:'
  puts response
end

if task == "add-document"
  count = ARGV[1] ? ARGV[1].to_i : 1

  count.times do |t|
    id = Faker::IDNumber.valid
    name = Faker::Name.name
    document = {
      name: name,
      phone:  Faker::PhoneNumber.phone_number,
      state: Faker::Address.state
    }

    response = client.index(
      index: index_name,
      body: document,
      id: id,
      refresh: true
    )

    puts "Adding contact: #{name}"
    puts response
  end
end

if task == "search"
  q = ARGV[1]
  puts "error search term required" && exit if q == nil

  query = {
    'size': 5,
    'query': {
      'multi_match': {
        'query': q,
        'fields': ['name^2', 'state']
      }
    }
  }

  response = client.search(
    body: query,
    index: index_name
  )
  puts 'Search results:'
  puts response
end
