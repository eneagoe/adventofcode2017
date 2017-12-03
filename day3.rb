#!/usr/bin/env ruby -w

# brute-force, not efficient
n = 1200
TURNING_STEPS = (0..n).map { |i| Integer((i + 2)**2/4) }

def walk_square_spiral(k)
  position = [0, 0]
  direction = [1, 0]
  (k-1).times.each do |step|
    if TURNING_STEPS.include?(step)
      direction = [-direction[1], direction[0]]
    end
    position = [position[0] + direction[0], position[1] + direction[1]]
  end

  return [position, position[0].abs + position[1].abs]
end


puts walk_square_spiral(1).join(" ")
puts walk_square_spiral(12).join(" ")
puts walk_square_spiral(23).join(" ")
puts walk_square_spiral(1024).join(" ")
puts walk_square_spiral(347991).join(" ")
