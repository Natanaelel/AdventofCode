T = Time.now
require "../lib/aoc.rb"

# get_input! 12
# test!

g = $<.map{|line|
    line.chomp.chars.map{|c|
        "SEa-z".fill.index(c)-2
    }
}

sx=0
sy=g.index{sx=_1.index(-2)}
gx=0
gy=g.index{gx=_1.index(-1)}

g[sy][sx]=0
g[gy][gx]=25

p *g
width = g[0].size
height = g.size


h = -> (from, to) {
    Math.hypot(from[0] - to[0].to_f, from[1] - to[1].to_f)
}

d = -> (from, to) {
    # from_val = g[from[1]][from[0]]
    # to_val = g[to[1]][to[0]]
    # (from_val - to_val).abs
    1

}

neighbors = -> pos {
    ans = []
    ans << [pos[0]-1, pos[1]] if pos[0] >= 1
    ans << [pos[0]+1, pos[1]] if pos[0] < width - 1
    ans << [pos[0], pos[1]-1] if pos[1] >= 1
    ans << [pos[0], pos[1]+1] if pos[1] < height - 1
    
    current_height = g[pos[1]][pos[0]]
    ans.select{|x,y|
        # current_height + 1 >= g[y][x]
        current_height <= 1 + g[y][x]
    }
}

reconstruct_path = -> (cameFrom, current){
    total_path = [current]
    while current = cameFrom[current]
        total_path.prepend(current)
    end
    return total_path
}

##// A* finds a path from start to goal.
##// h is the heuristic function. h(n) estimates the cost to reach goal from node n.
A_Star = -> (start, goal) {
    #// The set of discovered nodes that may need to be (re-)expanded.
    #// Initially, only the start node is known.
    #// This is usually implemented as a min-heap or priority queue rather than a hash-set.
    openSet = [start]

    #// For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
    #// to n currently known.
    cameFrom = {}

    #// For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    gScore = Hash.new 99999#map with default value of Infinity
    gScore[start] = 0

    #// For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
    #// how cheap a path could be from start to finish if it goes through n.
    fScore = Hash.new 99999##map with default value of Infinity
    fScore[start] = h.(start, start)

    until openSet.empty?
        #// This operation can occur in O(Log(N)) time if openSet is a min-heap or a priority queue
        current = openSet.min_by{|x|fScore[x]}# the node in openSet having the lowest fScore[] value
        # if current == goal
        if g[current[1]][current[0]] == 0# == goal
            return reconstruct_path.(cameFrom, current)
        end
        openSet-= [current]
        neighbors.(current).each{|neighbor|
            #// d(current,neighbor) is the weight of the edge from current to neighbor
            #// tentative_gScore is the distance from start to the neighbor through current
            tentative_gScore = gScore[current] + d.(current, neighbor)
            if tentative_gScore < gScore[neighbor]
                #// This path to neighbor is better than any previous one. Record it!
                cameFrom[neighbor] = current
                gScore[neighbor] = tentative_gScore
                fScore[neighbor] = tentative_gScore + h.(current, neighbor)
                if !openSet.include?(neighbor)
                    openSet << neighbor
                end
            end
        }
    end
    #// Open set is empty but goal was never reached
    return nil
}

start = [sx, sy]
goal = [gx, gy]
ans = 999999
p start, goal

# (0...height).each{|y|
#     (0...width).each{|x|
#         if g[y][x] == 0
#             res = A_Star.([x,y], goal)
#             next unless res
#             if res.size < ans
#                 ans = res.size
#                 puts "new min! #{ans} from #{[x,y]} path #{res}"
#             end
#         end
#     }
#     p [0,y]
# }.min

ans = A_Star.(goal, [nil,nil])
p ans
p ans.size - 1
p Time.now - T