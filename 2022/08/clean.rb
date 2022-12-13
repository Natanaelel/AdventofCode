require "../lib/aoc.rb"

get_input! 8
# test!


g = $<.map{|line|
    line.chomp.chars.ints
}
# p *g

mask = g.dup.map{|x|x.map{0}}

g.size.times{|y|
    height = -1
    g[y].each.with_index{|h,x|
        if h > height
            mask[y][x] = 1
            height = h
        end
    }
    height = -1
    g[y].reverse.each.with_index{|h,x|
        if h > height
            mask[y][g[0].size - x - 1] = 1
            height = h
        end
    }
}

g[0].size.times{|x|
    height = -1
    g.transpose[x].each.with_index{|h,y|
        if h > height
            mask[y][x] = 1
            height = h
        end
    }
    height = -1
    g.transpose[x].reverse.each.with_index{|h,y|
        if h > height
            mask[g.size - y - 1][x] = 1
            height = h
        end
    }
}

part1 = mask.flatten.sum

part2 = g.map.with_index{|row, y|
    row.map.with_index{|cell, x|
        
        left  = g          [y][0,x].reverse.index{|h| h >= cell }&.+(1) || x
        right = g          [y][x+1..]      .index{|h| h >= cell }&.+(1) || g[0].size - x - 1
        up    = g.transpose[x][0,y].reverse.index{|h| h >= cell }&.+(1) || y
        down  = g.transpose[x][y+1..]      .index{|h| h >= cell }&.+(1) || g.size    - y - 1
        
        left * right * up * down
    }.max
}.max

p part1
p part2

p Time.now-t