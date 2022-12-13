require "../lib/aoc.rb"

get_input! 4
# test!

p $<.count{|line|
    a,b = line.split(",").map{|l|
        x,y=l.split("-").map(&:to_i)
    }
    # (a[0] <= b[0] && a[1] >= b[1]) || (b[0] <= a[0] && b[1] >= a[1])
    (a[0]..a[1]).any?{|x|
        x >= b[0] && x <= b[1]
    }
}
