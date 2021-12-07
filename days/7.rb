a = open("./input.txt")


h = a.gets.split(",").map &:to_i

min, max = h.minmax
p min, max
p m = (0..1910).min_by{|x|h.map{|i|y=(i-x).abs;y*(y+1)/2}.sum}

p h.map{|i|x=(i-m).abs;x*(x+1)/2}.sum

