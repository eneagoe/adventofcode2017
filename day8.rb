#!/usr/bin/env ruby -w

class CPU
  attr_accessor :registers
  attr_accessor :max_ever

  def initialize
    @registers = {}
    @max_ever = -1/0.0
  end

  def inc(val)
    -> (register) { register + val }
  end

  def dec(val)
    -> (register) { register - val }
  end

  def method_missing(name, *args)
    @registers[name] ||= 0
    if args.first
      @registers[name] = args.first.call(@registers[name])
    end
    @max_ever = @registers[name] if @max_ever < @registers[name]
    @registers[name]
  end
end

cpu = CPU.new

File.open(ARGV[0]).each do |line|
  cpu.instance_eval(line)
end

# solution for first part of the puzzle
puts cpu.registers.values.max

# solution for second part of the puzzle
puts cpu.max_ever
