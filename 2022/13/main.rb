require "../lib/aoc.rb"

get_input! 13
# test!

# arr = gets.split.map &:to_i
# arr = $<.map &:to_i
# words = gets.split
str = [*$<]*""
arr = str.split("\n\n")

arr = arr.map{|x|
    x.lines.map{|line|
        eval line
    }
}

cmp = -> a, b {
    res = if Integer === a
        if Integer === b
            a <=> b
        else
            cmp.([a],b)
        end
    else
        if Integer === b
            cmp.(a,[b])

        else
            (0..).each{|i|
                x = a[i]
                y = b[i]
                if x == nil
                    if y == nil
                        return 0
                    else
                        return -1
                    end
                else
                    if y == nil
                        return 1
                    else
                        res = cmp.(x,y)
                        if res != 0
                            return res
                        end
                    end
                end
            }
            # a[0,b.size].zip(b).find{|x,y|cmp.(x,y)} ? true : a.size > b.size# ? true : !(a.size > b.size)
            # a.size == b.size ? !a.zip(b).find{|x,y|!cmp.(x,y)} : a.size < b.size
        end
    end
    # puts "input #{a} and #{b}\nres #{res}"
    # res
}

# p arr.map{|x,y|
#     cmp.(x,y)
# }
arr = arr.flat_map{|x|x}
arr << [[6]]
arr << [[2]]
arr.sort!{|x,y|cmp.(x,y)}
# indices = arr.each_index.select{|i|
#     -1==cmp.(*arr[i])
    
#     # (arr[i][0] <=> arr[i][1]) == 1
# }

# p indices
# p1! indices.map{|x|x+1}.sum
# p *arr

i = arr.index([[6]])
j = arr.index([[2]])

p i,j,i*j
p2! (i+1) * (j+1)