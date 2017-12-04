#!/usr/bin/env ruby -w

require 'set'

def valid_password?(password)
  words = password.split(/\s+/)
  anagrams = Set.new

  words.each do |word|
    return false unless word =~ /\A[[:lower:]]+\z/
    word = word.split(//).sort.join('')
    return false if anagrams.include?(word)
    anagrams << word
  end

  true
end

valid_passwords_count = File.open(ARGV[0]).count do |line|
  valid_password?(line.chomp)
end

puts valid_passwords_count
