a = open("./input.txt")

cubes = []

a.each{|line|
    x0, x1, y0, y1, z0, z1 = line.scan(/-?\d+/).map(&:to_i)

    cubes.dup.each{|ox0, ox1, oy0, oy1, oz0, oz1, val|
        sx0 = [x0, ox0].max
        sx1 = [x1, ox1].min
        sy0 = [y0, oy0].max
        sy1 = [y1, oy1].min
        sz0 = [z0, oz0].max
        sz1 = [z1, oz1].min
        overlap = [sx1 - sx0 + 1, 0].max * [sy1 - sy0 + 1, 0].max * [sz1 - sz0 + 1, 0].max
        if overlap > 0
            overlap_cube = [sx0, sx1, sy0, sy1, sz0, sz1, val * -1]
            cubes << overlap_cube
        end
    }
    cubes << [x0, x1, y0, y1, z0, z1, 1] if line["on"]
}

p cubes.sum{|x0, x1, y0, y1, z0, z1, v|
    (x1 - x0 + 1) * (y1 - y0 + 1) * (z1 - z0 + 1) * v
}