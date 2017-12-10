#!/usr/bin/env ruby -w

require 'ap'

list = (0..255).to_a
current_position = 0
skip_size = 0

lengths = File.open(ARGV[0]).read.split(/,/).map(&:to_i)

lengths.each do |len|
  rotated = (current_position...current_position+len).map do |pos|
    list[pos % list.size]
  end.reverse!

  (current_position...current_position+len).each do |pos|
    list[pos % list.size] = rotated[pos - current_position]
  end

  current_position = (current_position + len + skip_size) % list.size
  skip_size += 1
end

puts list[0] * list[1]
