require "../lib/aoc.rb"

get_input! 9
# test!

visited = [[0, 0].vec]
tail  = [0, 0].vec
head = [0, 0].vec

tails = 9.times.map{[0, 0].vec}

$<.each{|line|
    dir, times = line.split
    times.to_i.times{
        # move head
        head += dir.vec
        # move tail
        (0..8).each{|i|
            _head = i == 0 ? head : tails[i-1]
            _tail = tails[i]
            diff = _head - _tail
            diag = diff.sum(&:abs) == 3

            if diff.x == 2 || (diff.x == 1 && diag)
                _tail.x += 1
            elsif diff.x == -2 || (diff.x == -1 && diag)
                _tail.x -= 1
            end
            if diff.y == 2 || (diff.y == 1 && diag)
                _tail.y += 1
            elsif diff.y == -2 || (diff.y == -1 && diag)
                _tail.y -= 1
            end
        }
        visited << tails[-1].dup


    }
}

p visited.uniq.size
