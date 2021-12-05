a = open("./input.txt")


lines = a.map(&:chomp)

nums = lines.map(&:to_i)

spl = lines.map(&:split)


laps = []

lines.each{|line|
    x1,y1,x2,y2=line.scan(/-?\d+/).map(&:to_i)

    if x1==x2
        eval([y1,y2].minmax.join("..")).each{|y|
        laps << [x1, y]
    }
    elsif y1==y2
    eval([x1,x2].minmax.join("..")).each{|x|
            laps << [x, y1]
        }
    else
        (x1,y1),(x2,y2)=[[x1,y1],[x2,y2]].sort
        if y1<y2
            (0..x2-x1).map{|i|
                laps<<p([x1+i,y1+i])
            }
        else
            (0..x2-x1).map{|i|
                laps<<[x1+i,y1-i]
            }
        end

    end
}

p laps.tally.select{|k,v|v>=2}.size




