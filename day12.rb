#!/usr/bin/env ruby -w

require 'ap'

require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/condensation'

nodes = []
File.open(ARGV[0]).each do |line|
  origin, destinations = line.chomp.split(/\s*\<\-\>\s*/)
  destinations = destinations.split(/\s*,\s+/)
  nodes << [origin].product(destinations)
end

graph_nodes = nodes.flatten.map(&:to_i)

dg = RGL::DirectedAdjacencyGraph[*graph_nodes]
# interesting, not very useful
# dg.write_to_graphic_file('png')

components = dg.condensation_graph

connected_component_of_zero = components.select do |o|
  o.include? 0
end[0]

# solution to first part of the puzzle
ap connected_component_of_zero.size
# solution to second part of the puzzle
ap components.size
