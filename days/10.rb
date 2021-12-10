a = open("./input.txt")


lines = a.map(&:chomp)

score = 0
scores = []
lines.each{|line|
    100.times{

        line = line.gsub("<>","")
        line = line.gsub("()","")
        line = line.gsub("[]","")
        line = line.gsub("{}","")
    }
    
    if line[/[\]\)\}\>]/]
        next
    end

    if line[0]
        scores<< p(line.chars.map.with_index{|c,i|" ([{<".index(c) * (5 ** (i))}.sum)

        # score += line.count(">") * 25137
        # score += line.count("]") * 57
        # score += line.count("}") * 1197

    end
}

p scores.sort[scores.size / 2]
