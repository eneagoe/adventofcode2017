#!/usr/bin/env ruby -w

registers = Hash.new(0)
last_sound_frequency = nil
pc = 0
instructions = File.open(ARGV[0]).readlines.map(&:chomp)

loop do
  line = instructions[pc]
  case line
  when /\Asnd\s+(\w+)\z/
    last_sound_frequency = registers[$1]
  when /\Aset\s+(\w+)\s+(-?\w+)\z/
    registers[$1] = Integer($2) rescue registers[$2]
  when /\Aadd\s+(\w+)\s+(-?\w+)\z/
    registers[$1] += (Integer($2) rescue registers[$2])
  when /\Amul\s+(\w+)\s+(-?\w+)\z/
    registers[$1] *= (Integer($2) rescue registers[$2])
  when /\Amod\s+(\w+)\s+(-?\w+)\z/
    registers[$1] %= (Integer($2) rescue registers[$2])
  when /\Ajgz\s+(\w+)\s+(-?\d+)\z/
    unless registers[$1].zero?
      pc += (Integer($2) rescue registers[$2])
      next
    end
  when /\Arcv\s+(\w+)\z/
    unless registers[$1].zero?
      break
    end
  end
  pc += 1
end

puts last_sound_frequency
