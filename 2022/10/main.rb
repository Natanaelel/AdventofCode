require "../lib/aoc.rb"

get_input! 10
# test!

delay = 1
strength = 0
x = 1
add = false
num = 0
ans = 6.times.map{" "*40}
xc = 0
yc = 0
240.times{|i|
    ans[yc][xc] = (x .. x+2) === xc ? "#" : "." 

    xc += 1
    if xc == 40
        yc += 1
        xc = 0
    end
    delay -= 1
    if [20,60,100,140,180,220].include?(i)
        strength += x * i
        p [i, strength, x]
    end
    if delay == 0
        if add
            x += num
            puts "#{i}: added #{num}, sum: #{x-num} -> #{x}"
        end
        add = false
        str = gets.split
        if str[0] == "noop"
            delay = 1
        else
            add = true
            num = str[1].to_i
            delay = 2
        end
    end    
}

p strength
puts ans