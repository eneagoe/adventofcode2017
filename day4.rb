#!/usr/bin/env ruby -w

def valid_password?(password)
  words = password.split(/\s+/)
  words.size == words.uniq.size && words.all? { |w| w =~ /\A[[:lower:]]+\z/ }
end

valid_passwords_count = File.open(ARGV[0]).count do |line|
  valid_password?(line.chomp)
end

puts valid_passwords_count
