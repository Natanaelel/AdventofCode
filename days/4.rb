a = open("./input.txt")

# lines = a.map{|line|line.chomp}

# sp = lines.map{|x|x.split}

# nums = lines.map{|x|x.to_i}


guesses = a.gets.split(",").map(&:to_i)

boards = [*a].drop(1).join("\n").split("\n\n\n")

boards = boards.map{|x|x.split("\n\n").map{|r|r.split.map(&:to_i)}}
# p boards
# p boards.take 10
b = false
said = []
inds = []
loop{
    
    move = guesses.shift
    said<<move
    boards = boards.each.with_index{|nums,ind|
    
    # if nums.flatten.index move
    #     pl<<[bo,nums.map{|x|x.index(bo)}.find{_1}]
    # end
    # p nums
    rows = nums + nums.transpose rescue p(nums)
    # p rows
    full = rows.find{|r|r.all?{|v|said.include? v}}
    if full
        # b = true
        gli = ind
        score = nums.flatten.select{|v|!said.include?(v)}.sum * move
        inds<<ind
        p score if boards.size==1
        boards.delete_at ind
        # puts "sum = %d, move = %d" % [nums.flatten.select{|v|!said.include?(v)}.sum , move]
        # p ind
        # p full
        # p nums
        # p said,move
        # exit

    end
    
}
    break if b
}
# p boards


