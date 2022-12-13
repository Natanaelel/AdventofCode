require "../lib/aoc.rb"

get_input! 10
# test!

delay = 1
strength = 0
x = 1
ans = [" "*40]**6
last = ""
240.times{|i|
    ans[i/40][i%40] = (x .. x+2) === i%40 ? "#" : " " 

    delay -= 1
    strength += x * i if i % 40 == 20

    next unless delay == 0
    x += last[1].to_i if last[0] == "addx"
    last = gets.split
    delay = last[0] == "noop" ? 1 : 2
    
}
p strength
puts ans