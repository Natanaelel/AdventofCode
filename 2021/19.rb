a = open("./input.txt")

scanners = a.read.split("\n\n").map{|scanner|
    scanner.lines.drop(1).map{|line|
        line.split(",").map(&:to_i)
    }
}

def rotations(scanner)
    scanner.map{|x,y,z|
        [
            [x,y,z],
            [x,-y,-z],
            [-x,-y,z],
            [-x,y,-z],

            [x,z,-y],
            [x,-z,y],
            [-x,z,y],
            [-x,-z,-y],

            
            [y,z,x],
            [y,-z,-x],
            [-y,-z,x],
            [-y,z,-x],
            
            [y,x,-z],
            [y,-x,z],
            [-y,x,z],
            [-y,-x,-z],


            [z,x,y],
            [z,-x,-y],
            [-z,-x,y],
            [-z,x,-y],
            
            [z,y,-x],
            [z,-y,x],
            [-z,y,x],
            [-z,-y,-x]

        ]
    }.transpose
end


all_points, *scanners = scanners


positions = [[0, 0, 0]]

loop{
    p ["size", scanners.size]
    break unless scanners.find.with_index{|scanner, scanner_index|
        rotations(scanner).any?{|rotation|
            offset = all_points.flat_map{|px,py,pz|
                rotation.map{|x,y,z|
                    [px-x, py-y, pz-z]
                }
            }.tally.find{|k,v|v>=12}

            next unless offset

            ox, oy, oz = offset[0]
            points = rotation.map{|x,y,z|[x+ox, y+oy, z+oz]}
            
            positions << offset[0]

            all_points |= points
            scanners.delete_at(scanner_index)
            
        }

    }
}

p all_points.size

p positions.flat_map{|x0,y0,z0|
    positions.map{|x1,y1,z1|
        (x0-x1).abs + (y0-y1).abs + (z0-z1).abs
    }
}.max