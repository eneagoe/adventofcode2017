#!/usr/bin/env ruby -w

# very inefficient, too much memory usage
n = 1200

K = 347991

TURNING_STEPS = (0..n).map { |i| Integer((i + 2)**2/4) }
VALUES = Array.new(600) { Array.new(600, 0) }

def walk_square_spiral(k)
  value_position = [300, 300]
  VALUES[value_position[0]][value_position[1]] = 1
  position = [0, 0]
  direction = [1, 0]
  (k-1).times.each do |step|
    if TURNING_STEPS.include?(step)
      direction = [-direction[1], direction[0]]
    end
    position = [position[0] + direction[0], position[1] + direction[1]]
    value_position = [value_position[0] + direction[0],
                      value_position[1] + direction[1]]
    VALUES[value_position[0]][value_position[1]] = [
      VALUES[value_position[0] + 1][value_position[1]],
      VALUES[value_position[0] + 1][value_position[1] + 1],
      VALUES[value_position[0]][value_position[1] + 1],
      VALUES[value_position[0] - 1][value_position[1] + 1],
      VALUES[value_position[0] - 1][value_position[1]],
      VALUES[value_position[0] - 1][value_position[1] - 1],
      VALUES[value_position[0]][value_position[1] - 1],
      VALUES[value_position[0] + 1][value_position[1] - 1],
    ].sum

    if VALUES[value_position[0]][value_position[1]] > K
      return [position, VALUES[value_position[0]][value_position[1]]]
    end
  end

end

puts walk_square_spiral(347991).join(" ")
