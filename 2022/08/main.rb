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
        res = h > height
        if res
            mask[y][x] = 1
        end
        height = h if res#hres
    }
    height = -1
    g[y].reverse.each.with_index{|h,x|
        res = h > height
        if res
            mask[y][g[0].size - x - 1] = 1
        end
        height = h if res#res
    }


}

g[0].size.times{|x|
    height = -1
    g.transpose[x].each.with_index{|h,y|
        res = h > height
        if res
            mask[y][x] = 1
        end
        height = h if res
    }
    height = -1
    g.transpose[x].reverse.each.with_index{|h,y|
        res = h > height
        if res
            mask[g.size - y - 1][x] = 1
        end
        height = h if res#res
    }


}

scores =  g.map.with_index{|row,y|
    row.map.with_index{|c,x|
        once = true
        cell = c
        cell2 = c
        left = g[y].take([x,0].max).reverse.select{|h|
            res = h < cell
            # cell = h if h < cell2
            once && (res || (once && (!once = false)))
        }
        once = true
        cell = c
        right = g[y][x+1..].select{|h|
            res = h < cell
            # cell = h if h > cell
            once && (res || (once && (!once = false)))
        }
        once = true
        cell = c
        up = g.transpose[x].take([y,0].max).reverse.select{|h|
            res = h < c
            # cell = h if h > c
            once && (res || (once && (!once = false)))
        }
        once = true
        cell = c
        down = g.transpose[x][y+1..].select{|h|
            res = h < cell
            # cell = h if h > cell
            once && (res || (once && (!once = false)))
        }
        [left, right, up, down]
        
        left.size * right.size * up.size * down.size

    }
}
# p *scores
p scores.flatten.max

# p mask
# p mask.flatten.sum