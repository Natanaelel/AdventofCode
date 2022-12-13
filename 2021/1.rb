$a = open("./input.txt")

p [*$a].map(&:to_i).each_cons(3).map(&:sum).each_cons(2).count{_1.to_i<_2.to_i}

