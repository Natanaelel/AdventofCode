require "../lib/aoc.rb"

get_input! 13
# test!

str = [*$<]*""
arr = str
    .split("\n\n")
    .map{|x| x.lines.map{eval _1} }

class Array
    alias old_cmp <=>
    def <=>(b)
        Array === b ? old_cmp(b) : self <=> [b]
    end
end
class Integer
    alias old_cmp <=>
    def <=>(b)
        Integer === b ? old_cmp(b) : [self] <=> b
    end
end
p1! arr.indices(&:sorted?).sum(&:succ)

arr.flatten! 1
arr << [[6]]
arr << [[2]]
arr.sort!
arr >> 0
i = arr.index [[6]]
j = arr.index [[2]]

p2! i * j
