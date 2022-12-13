require "../lib/aoc.rb"

g = $<.map &:chomp

start = g.index2("S").vec
goal = g.index2("E").vec

g[start.y][start.x] = "a"
g[goal.y][goal.x] = "z"

get_neighbor_pos = -> pos {
    current_height = g[pos.y][pos.x]
    Search
        .neighbors4(pos)
        .grep(
            Search.neighbors_in_grid(g[0].size, g.size)
        )
        .select{|new_pos|
            current_height.ord <= 1 + g[new_pos.y][new_pos.x].ord
        }
}
get = -> pos { g[pos.y][pos.x] }

p1 = Search.BFS_grid(
        grid: g,
        start: goal,
        get_neighbor_pos: get_neighbor_pos,
        get: get,
        goal: It == start
    ).size

p2 = Search.BFS_grid(
        grid: g,
        start: goal,
        get_neighbor_pos: get_neighbor_pos,
        get: get,
        goal: get >> (It == "a")
    ).size

p p1, p2