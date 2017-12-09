#!/usr/bin/env ruby -w

require 'ap'

def score(line)
  line_total = 0
  garbage_total = 0
  stack = []
  current_level = 1
  prev_char = ''
  in_garbage = false

  line.chars.each do |c|
    if !in_garbage
      if c == '{'
        stack << current_level
        current_level += 1
      elsif c == '}'
        line_total += stack.pop
        current_level -= 1
      elsif c == '<'
        in_garbage = true
      end
      prev_char = c
    else
      if c == '>' && prev_char != '!'
        in_garbage = false
      else
        garbage_total += 1 unless prev_char == '!' || c == '!'
      end
      if c == '!' && prev_char == '!'
        prev_char = ' '
      else
        prev_char = c
      end
    end
  end

  [line_total, garbage_total]
end

File.open(ARGV[0]).each do |line|
  puts(score(line.chomp))
end
