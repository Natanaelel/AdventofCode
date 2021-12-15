a = open("./input.txt")


def findMinCost2(cost)
 
    w = cost.size
 
    t = ([0]*w).map{[0]*w}
 
    (0...w).each{|i|
        (0...w).each{|j|
            t[i][j] = cost[i][j]

            if i == 0 && j > 0
                t[0][j] += t[0][j - 1]
            elsif j == 0 && i > 0
                t[i][0] += t[i - 1][0]
            elsif i > 0 && j > 0
                t[i][j] += [t[i - 1][j], t[i][j - 1]].min
            end
        }
    }
    return t[-1][-1]
end



g =  a.map{|line|line.chomp.chars.map(&:to_i)}

g = (0..4).flat_map{|yo|
    g.map{|row|
        (0..4).flat_map{|xo|
            row.map{|el|
                (el + yo + xo - 1) % 9 + 1
                
            }
        }
    }
}

# p *g

p findMinCost2(g)
