input = open("./input.txt")


a = input.gets.split(",").map &:to_i

t = a.tally
256.times{|i|
    n = []
    h = {}
    t.each{|f,num|
        v = f - 1
        if v >= 0
            # n<<v
            h[v]||=0
            h[v]+=num
        else
            # n<<6
            h[6]||=0
            h[6] += num
            # n<<8
            h[8]||=0
            h[8] += num

        end

    }
    a = n
    t = h.dup

}
p a.size
p t
p t.sum{_2}

