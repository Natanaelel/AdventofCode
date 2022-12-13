require "../lib/aoc.rb"

get_input! 5
# test!
a, b = [*$<].join.split("\n\n")

p a,b

r = (0..(a.size+1)/4)

a = r.map{|i|
    a.lines.map{|line|
        line[i*4,3]
    }
}
p *a
len = a[0].size - 1
stacks = a.map{|x|x[0,len]}
stacks = stacks.select{|x|x && x[0] && x[0]!=""}
stacks = stacks.map{|stack|stack.select{|x|x!="   "}.map{|x|x[1]}}
# p stacks
stacks.map!(&:reverse)

b.lines.each{|line|
    p line
    num, from, to = line.find_ints
    tomove = []
    num.times{
        tomove << stacks[from-1].pop
    }
    stacks[to-1] += tomove.reverse
}
p stacks.map{|x|x[-1]}*""

#!TPGVQPFDH