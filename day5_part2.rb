#!/usr/bin/env ruby -w

instructions = File.open(ARGV[0]).map { |line| line.chomp.to_i }
pc = 0
steps = 0
program_size = instructions.size

while pc >= 0 && pc < program_size
  offset = instructions[pc]
  if offset >= 3
    instructions[pc] -= 1
  else
    instructions[pc] += 1
  end
  pc += offset
  steps += 1
end

puts steps
