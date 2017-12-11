#!/usr/bin/env ruby -w

require 'ap'

# use odd-q representation of a hexagonal grid and compute the
# Manhattan distance on the grid between (0, 0) and final position

def offset_distance(x1, y1, x2, y2)
  ac = offset_to_cube(x1, y1)
  bc = offset_to_cube(x2, y2)
  cube_distance(ac, bc)
end

def offset_to_cube(row, col)
  x = col - (row - row % 2) / 2
  z = row
  y = -(x + z)

  [x, z, y]
end

def cube_distance(p1, p2)
  a = (p1[0] - p2[0]).abs
  b = (p1[1] - p2[1]).abs
  c = (p1[2] - p2[2]).abs

  [a, b, c].max
end

even_col_dir = {
  'se' => [1, 0],
  'ne' => [1, -1],
  'n'  => [0, -1],
  'nw' => [-1, -1],
  'sw' => [-1, 0],
  's'  => [0, 1]
}

oddcol_dir = {
  'se' => [1, 1],
  'ne' => [1, 0],
  'n'  => [0, -1],
  'nw' => [-1, 0],
  'sw' => [-1, 1],
  's'  => [0, 1]
}

moves = File.open(ARGV[0]).read.chomp.split(/,/)
# TEST MOVES
# moves = 'ne,ne,ne'.split(/,/)
# moves = 'ne,ne,sw,sw'.split(/,/)
# moves = 'ne,ne,s,s'.split(/,/)
# moves = 'se,sw,se,sw,sw'.split(/,/)

max_ever_distance = 0
position = [0, 0]

moves.each do |direction|
  offset = position[0].odd? ? oddcol_dir[direction] : even_col_dir[direction]
  position = position.zip(offset).map { |x, y| x + y }
  max_ever_distance = [offset_distance(0, 0, position[0], position[1]),
                       max_ever_distance].max
end

ap position
puts offset_distance(0, 0, position[0], position[1])
puts max_ever_distance
