#!/usr/bin/ruby -w

require 'set'
require 'awesome_print'

programs = 'abcdefghijklmnop'

moves = File.read(ARGV[0]).chomp.split(/,\s*/)

loop_counter = 1000000000
cycles = Set.new()
cycles << programs

loop_counter.times do |counter|
  moves.each do |move|
    case move
    when /s(\d+)/
      i = $1.to_i
      programs = programs[-i..-1] + programs[0...-i]
    when /x(\d+)\/(\d+)/
      i, j = $1.to_i, $2.to_i
      programs[i], programs[j] = programs[j], programs[i]
    when /p(\w)\/(\w)/
      i = programs.index($1)
      j = programs.index($2)
      programs[i], programs[j] = programs[j], programs[i]
    end
  end

  # first part of the puzzle
  puts programs if counter == 0
  if cycles.include?(programs)
    # second part of the puzzle
    puts cycles.to_a[loop_counter % (counter + 1)]
    break
  else
    cycles << programs
  end
end
