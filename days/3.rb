a = open("./input.txt")

# na = a.map{|x|x.to_i(2)}
na = a.map &:chomp

# bits = na.map{|x|x.digits(2)}

# ar = (0..11).to_a.map{|i|
#     b = na.map{|x|x[i]&.to_i||0}
#     t=b.tally
#     t.max_by{|k,v|v}[0]
# }
# p ar
# ar.reverse!
# a = ar.join.to_i(2) 
# b = ar.map{|x|1-x}.join.to_i(2)
# p a * b
# p [a,b]

i = 0
while na.size > 1
    c = na.map{|x|x[i].to_i}.tally
    # v = c.sort_by{|k,v|-k}.min_by{|k,v|v}[0]
    v = c[1] < c[0] ? 1 : 0
    na = na.select{|x|x[i].to_i==v}

    i+=1
end

p na
p 0b111010110111 * 0b010011100011
p 0b111010101100 * 0b010011101100
p 0b111010111111 * 0b010010000111