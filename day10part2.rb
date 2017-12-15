#!/usr/bin/env ruby -w

require 'ap'

list = (0..255).to_a
# list = (0..4).to_a
current_position = 0
skip_size = 0

lengths = File.open(ARGV[0]).read.chomp.each_char.map(&:ord)
lengths += [17, 31, 73, 47, 23]

64.times do |i|
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
end

knot_hash = list.each_slice(16).map do |groups|
  hex_chars = groups.to_a.reduce(&:^).to_s(16)
  if hex_chars.size == 1
    hex_chars = '0' + hex_chars
  end
  hex_chars
end

# 2f8c3d2100fdd57cec130d928b0fd2dd
ap knot_hash
