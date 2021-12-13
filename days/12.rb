a = open("./input.txt")

lines = a.map(&:chomp).map.with_index{|x,i|[x.split("-"),i]}


getpossible = -> node {
    lines.select{|(st,ed),idx|
        st == node
    } + lines.filter_map{|(ed,st),idx|
        st == node && [[st,ed],idx]
    }
}

# path :: [path, visited, visited_small_twice]
# path :: [path,                    visited,   visited_small_twice]
# path :: [ [ [[st,ed],idx], ... ], ["a","b"], false]

# paths :: [path]

travel = -> paths {
    _paths = []
    paths.each{|(path, visited, visited_small_twice)|
        last_pos = path[-1]
        possible = getpossible[last_pos[0][1]]

        possible.each{|(st0, ed0), idx0|
            _visited_small_twice = visited_small_twice
            if visited_small_twice
                next if visited.include?(ed0)
            else
                if visited.include?(ed0)
                    next if ed0 == "start"    
                    _visited_small_twice = true
                end
                
            end
            new_visited = visited.dup
            new_visited << ed0 if ed0 =~ /[a-z]/
            _paths << [path + [[[st0, ed0], idx0]], new_visited, _visited_small_twice]

        }

    }

    finished, not_finished = _paths.partition{|path|path[0][-1][0][1] == "end"}

    recursive = not_finished.flat_map{|path|travel[[path]]}
    return finished + recursive
}

starts = getpossible["start"].map{|start|[[start], ["start"] + (start[0][1][/[a-z]+/] ? [$&] : []), false ]}

done = travel[starts]

puts "done:"
p done.uniq.size
