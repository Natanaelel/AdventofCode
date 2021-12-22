@tallied = (1..3).to_a.repeated_permutation(3).map(&:sum).tally.map{|k,v|[k-1,v]}.to_h

@cache = {}

def game(a, b, as, bs, turn)
    return [1, 0] if as <= 0
    return [0, 1] if bs <= 0
    key = [a,b,as,bs,turn]
    cached = @cache[key]
    return cached if cached


    nas = nbs = 0
    inv = turn^1
    @tallied.each{|die, universes|
        

        apos = a * inv + ((a + die) % 10 + 1) * turn
        bpos = b * turn + ((b + die) % 10 + 1) * inv


        aa, bb = game(apos, bpos, as - apos*turn, bs - bpos*inv, inv)
        nas += aa * universes
        nbs += bb * universes
    }
    @cache[key] = [nas, nbs]

end

input = open("./input.txt")
a, b = input.map{|line|line[/\d+$/].to_i}

p game(a, b, 21, 21, 1)




