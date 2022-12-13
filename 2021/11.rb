a = open("./input.txt")


g = a.map{|x|x.chomp.chars.map{|y|[false, y.to_i]}}

w = g[0].size
h = g.size

fl = 0

10000.times{|i|
    fl0 = 0
    f = -> xx,yy{
        return if xx < 0
        return if xx >= w
        return if yy < 0
        return if yy >= h
        return if g[yy][xx][0]
        g[yy][xx][1] += 1
        if g[yy][xx][1] == 10
            fl += 1
            fl0 += 1
            g[yy][xx][1] = 0
            g[yy][xx][0] = true

            f[xx - 1, yy]
            f[xx + 1, yy]
            f[xx, yy + 1]
            f[xx, yy - 1]

            f[xx + 1, yy - 1]
            f[xx - 1, yy - 1]
            f[xx - 1, yy + 1]
            f[xx + 1, yy + 1]

        end
    }
    (0...h).map{|y|
        (0...w).map{|x|
            g[y][x][0] = false
        }
    }
    (0...h).map{|y|
        (0...w).map{|x|
            f[x,y]
        }
    }
    if fl0 == w * h
        p i + 1
        exit
    end
}


p fl