require "../lib/aoc.rb"

get_input! 7
# test!

path = []
dir = tree = {}

$<.each{|s|
    case s
    when /^\$ cd \.\./
        path.pop
        dir = tree.dig *path
    when /^\$ cd (.+)/
        path.push $1
        dir = dir[$1] = {}
    when /^(\d+) (.+)/
        dir[$2] = $1.to_i
    end
}

sums = []
tree_sum = -> node {
    node
        .sum{Integer === _2 ? _2 : tree_sum[_2]}
        .tap{sums << _1}
}
to_remove = tree_sum[tree] - 40000000
p sums.select{_1 <= 100000}.sum
p sums.select{_1 >= to_remove}.min