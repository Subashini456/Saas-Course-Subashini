def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html

  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

# ..
# ..
# FILL YOUR CODE HERE# ..
# ..

def parse_dns(dns_raw)
  dns_records = {}
  dns_filter = dns_raw.select { |x| x[0] != "#" and x != "\n" }

  dns_filter.each do |line|
    arr = line.split(", ")
    dns_records[arr[1].strip] = { :type => arr[0].strip, :destiny => arr[2].strip }
  end

  return dns_records
end

def resolve(dns_records, lookup_chain, domain)
  search = dns_records[domain]

  if (search.nil?)
    lookup_chain.push("Error: record not found for " + domain)
    return lookup_chain
  elsif (search[:type] == "A")
    lookup_chain.push(search[:destiny])
    return lookup_chain
  elsif (search[:type] == "CNAME")
    domain = search[:destiny]
    lookup_chain.push(domain)
    resolve(dns_records, lookup_chain, domain)
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
