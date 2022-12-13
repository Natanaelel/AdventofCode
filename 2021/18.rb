asdsfasdf = open("./input.txt")

@logging = false

def magnitude(num) = Numeric === num ? num : 3 * magnitude(num[0]) + 2 * magnitude(num[1])

def add(left, right) = reduce([left, right])

def reduce(num)
    loop{
        p num if @logging

        # explode
        l4 = find_level_4_pair(num)
        if l4
            p "explode" if @logging
            pair = num[l4[0]][l4[1]][l4[2]][l4[3]]
            num[l4[0]][l4[1]][l4[2]][l4[3]] = 0
            n = l4.join.to_i(2)
            left = n > 0 && ("%04b" % (n-1)).chars.map(&:to_i) + [1]
            right = n < 15 && ("%04b" % (n+1)).chars.map(&:to_i) + [0]
            
            num = add_at_path(num, left, pair[0]) if left
            num = add_at_path(num, right, pair[1]) if right
            p ["left-right", [left, right]] if @logging
            p ["pair", pair] if @logging
            next
        end
        
        #split
        more10 = find_greater_than_10(num)
        if more10
            p "split" if @logging
            number = num.dig(*more10)
            num = dig_equals(num, more10, [number / 2, (number / 2.0).ceil])
            next
        end
        
        return num
    }
end

def add_at_path(num, path, plus)
    (1..5).find{|i|
        n = num.dig(*path[0,i])
        dig_equals(num, path[0,i], n + plus) if Numeric === n
    }
    return num
end

def find_level_4_pair(num, path = []) # :: nil | [0, 1, 1, 0]
    return if Numeric === num
    return path if path.size == 4
    return find_level_4_pair(num[0], path + [0]) || find_level_4_pair(num[1], path + [1])
end

def find_greater_than_10(num, path = [0]) # :: nil | [0|1]+
    n = [num].dig(*path)
    return path[1..] if Numeric === n && n >= 10
    return if Numeric === n
    return find_greater_than_10(num, path + [0]) || find_greater_than_10(num, path + [1])
end

def dig_equals(arr, path, val)  # (hash|arr).dig(*path) but set instead of get
    return unless arr.dig(*path)
    eval "arr" + path.map{|e|"[#{e}]"}.join + "= val"
    return arr
end

input = asdsfasdf.map{|line|eval line}

dup = -> a {Numeric === a ? a : a.map(&dup)}

p magnitude dup[input].reduce{|a,b|add(a,b)}

p (0...input.size).map{|a|
    (0...input.size).map{|b|
        a == b ? 0 : magnitude(add(dup[input[a]], dup[input[b]]))
    }.max
}.max