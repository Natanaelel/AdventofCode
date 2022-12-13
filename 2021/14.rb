a = open("./input.txt")

s, r = a.read.split("\n\n")

@h = r.lines.map{|x|x.chomp.split(" -> ")}.to_h

def replacement(s) = s.chars.each_cons(2).map{|a,b|a + @h[a + b]}.join + s[-1]

def tally_pairs(s) = s.chars.each_cons(2).map(&:join).tally

def update(hash)
    new_hash = Hash.new 0
    hash.each{|k, v|
        tally_pairs(replacement(k)).each{|kk, vv|
            new_hash[kk] += vv * v # <- this is where things happen
        }
    }
    new_hash
end

hash = tally_pairs s

40.times{
    hash = update hash
}

pairs = Hash.new 0

hash.each{|k, v| pairs[k[0]] += v }
t = pairs.values

p t.max - t.min - 1