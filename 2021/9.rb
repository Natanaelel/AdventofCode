a = open("./input.txt")


lines = a.map(&:chomp)


h = lines.size
w = lines[0].size
low = []
coords = []
(0...h).map{|y|
    (0...w).map{|x|
        na = []
        
        na << lines[y][x-1].to_i if x > 0
        na << lines[y-1][x].to_i if y > 0        
        na << lines[y][x+1].to_i if x < w-1
        na << lines[y+1][x].to_i if y < h-1

        if na.all?{|px|px > lines[y][x].to_i}
            low<<lines[y][x].to_i
            coords << [y,x]
        end
    }
}

p low.sum{|x|x+1}

sa = []

coords.map{|y,x|
    basinsize = 1
    f = -> yc,xc,v{
        return unless (0...w) === xc && (0...h) === yc
        return if "9_"[lines[yc][xc]]
        nv = lines[yc][xc].to_i
        return unless nv > v

        lines[yc][xc] = "_"
        basinsize += 1

        f[yc + 1, xc, nv]
        f[yc - 1, xc, nv]
        f[yc, xc - 1, nv]
        f[yc, xc + 1, nv]
    }
    v = lines[y][x].to_i
    lines[y][x] = "_"
    f[y-1,x,v]
    f[y+1,x,v]
    f[y,x-1,v]
    f[y,x+1,v]
    
    sa << basinsize
}
p sa.sort.reverse[0,3].inject(:*)