#!/usr/bin/env ruby -w

require 'tsort'
require 'awesome_print'
require 'graphviz'

class Hash
  include TSort

  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    fetch(node).each(&block) if key?(node)
  end
end

@tree = Hash.new { |h, key| h[key] = [] }
@weights = Hash.new { |h, key| h[key] = [] }
@cumulative_weights = Hash.new { |h, key| h[key] = [] }
graph = Graphviz::Graph.new('Tree')

def tree_sum(parent, level = 0)
  weight = 0
  @tree[parent].each do |child|
    weight += tree_sum(child, level + 1)
  end
  weight += @weights[parent].first
  @cumulative_weights[parent] = [weight, level, @tree[parent]]
  weight
end

File.open(ARGV[0]).each do |line|
  if line.chomp =~ /\A(\w+)\s+\((\d+)\)\s+\-\>\s+(.+)\z/
    parent = $1
    @weights[$1] << $2.to_i
    $3.split(/,\s+/).each do |child|
      @tree[parent] << child
    end
  else
    line.chomp =~ /\A(\w+)\s+\((\d+)\)\z/
    @weights[$1] << $2.to_i
  end
end

root = @tree.tsort.last
# first puzzle solution
puts root

# second puzzle solution
tree_sum(root)
# TODO: find the solution
# HACK: print the weighted tree and find the solution manually
@cumulative_weights.each do |k, v|
  parent_node = graph.add_node "#{k} - #{v[0]}"
  v[2].each do |child|
    child_node = graph.add_node "#{child} - #{@cumulative_weights[child][0]}"
    parent_node.connect child_node
  end
end
Graphviz::output(graph, path:  "tree.pdf")
