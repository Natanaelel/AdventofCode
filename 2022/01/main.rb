str = [*$<]*""
p str

# s= [*$<]*""

p s.split("\n\n").map{|x|
    x.split.sum(&:to_i)
}.sort.reverse[0,3].sum