#!/usr/bin/env ruby -w

require 'rgl/adjacency'
require 'rgl/condensation'
require 'rgl/dot'

def knot_hash(word)
  list = (0..255).to_a
  current_position = 0
  skip_size = 0

  lengths = word.each_char.map(&:ord)
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

  list.each_slice(16).map do |groups|
    hex_chars = groups.reduce(&:^).to_s(16)
    hex_chars = '0' + hex_chars if hex_chars.length == 1
    hex_chars
  end.join
end

dg = RGL::DirectedAdjacencyGraph.new
graph = []

s = (0..127).sum do |i|
  x = knot_hash(ARGV[0].chomp + "-#{i}").to_i(16).to_s(2).rjust(128, '0').split(//)
  graph << x
  x.count("1")
end

# solution to first part of the puzzle
puts s

(0..127).each do |row|
  (0..127).each do |col|
    next if graph[row][col] == '0'
    dg.add_edge("#{row},#{col}", "#{row},#{col}")
    if row - 1 >= 0 && graph[row-1][col] == '1'
      dg.add_edge("#{row},#{col}", "#{row - 1},#{col}")
    end
    if row + 1 < 128 && graph[row+1][col] == '1'
      dg.add_edge("#{row},#{col}", "#{row + 1},#{col}")
    end
    if col - 1 >= 0 && graph[row][col-1] == '1'
      dg.add_edge("#{row},#{col}", "#{row},#{col-1}")
    end
    if col + 1 < 128 && graph[row][col+1] == '1'
      dg.add_edge("#{row},#{col}", "#{row},#{col+1}")
    end
  end
end

components = dg.condensation_graph

# solution to second part of the puzzle
puts components.size
