a = open("./input.txt")

instr, folds = a.read.split("\n\n").map(&:lines)

instr = instr.map{|line|
    line.split(",").map(&:to_i)
}

max = instr.flatten.max

g = (0..max).map{"."*(max+1)}

instr.each{|x, y|
    g[y][x]="#"
}

# folds = folds[0,1]

folds.each{|fold|
    
    fold =~ /([yx])=(\d+)/

    puts "error" unless $&
    
    n = $2.to_i

    g = g.map(&:chars).transpose.map(&:join) if $1 == "y"
    
    g = g.map{|row|
        a = row[0,n].chars
        b = row[n+1,n].chars
        a.zip(b.reverse).map{|q, r|q=="#" ? "#" : r}.join
    }

    g = g.map(&:chars).transpose.map(&:join) if $1 == "y"

}

puts g.join("\n").tr("."," ")

p g.join.count("#")