require "../lib/aoc.rb"

get_input! 9
# test!

visited = [[0, 0]]
tail  = [0, 0]
head = [0, 0]

tails = 9.times.map{[0, 0]}

$<.each{|line|
    dir, times = line.split
    times.to_i.times{
        # move head
        case dir
        when "R"
            head[0] += 1
        when "L"
            head[0] -= 1
        when "U"
            head[1] -= 1
        when "D"
            head[1] += 1
        end
        # move tail
        (0..8).each{|i|
            _head = i == 0 ? head : tails[i-1]
            _tail = tails[i]
            diff = _head[0] - _tail[0], _head[1] - _tail[1]
            diag = diff[0].abs + diff[1].abs == 3

            if diff[0] == 2 || (diff[0] == 1 && diag)
                _tail[0] += 1
            elsif diff[0] == -2 || (diff[0] == -1 && diag)
                _tail[0] -= 1
            end
            if diff[1] == 2 || (diff[1] == 1 && diag)
                _tail[1] += 1
            elsif diff[1] == -2 || (diff[1] == -1 && diag)
                _tail[1] -= 1
            end
        }
        visited << tails[-1].dup
        # p [movedx, movedy]


    }
}
# p *visited
p visited.uniq.size