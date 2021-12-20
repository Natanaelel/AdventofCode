a = open("./input.txt")

s, r = a.read.split("\n\n")

ITERATIONS = 50

g = r.lines.map(&:chomp)

w = g[0].size
h = g.size

g = ITERATIONS.times.map{"." * (w + ITERATIONS * 2)} + g.map{|r|"." * ITERATIONS + r + "." * ITERATIONS} + ITERATIONS.times.map{"." * (w + ITERATIONS * 2)}
g = g.map(&:chars)

w = g[0].size
h = g.size

ITERATIONS.times{
    g = (0...h).map{|y|
        (0...w).map{|x|
            idx = (-1..1).map{|yoff|
                (-1..1).map{|xoff|
                    g[(y + yoff).clamp(0, w - 1)][(x + xoff).clamp(0, h - 1)]
                }
            }.join.tr(".#", "01").to_i(2)
            s[idx]
        }
    }
}
p g.join.count("#")