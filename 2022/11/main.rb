require "../lib/aoc.rb"

get_input! 11
# test!
T = Time.now

str = [*$<]*""
arr = str.split("\n\n")

monkeys = arr.map{|str|
    name, items, operation, condition, truthy, falsy = str.split("\n")
    operation = if operation["*"]
        if operation.split[-1] == "old"
            -> x {x * x}
        else
            num = operation.split[-1].to_i
            -> x {x * num}
        end
    else
        num = operation.split[-1].to_i
        -> x {x + num}
    end
    [
        name[/\d+/].to_i,
        items.find_ints,
        operation,#.split(": ")[1],
        condition.split[-1].to_i,
        truthy.split[-1].to_i,
        falsy.split[-1].to_i,
        0#, # times inspected
    ]
}
lcm = monkeys.transpose[3].inject(:lcm)
10000.times{
    monkeys.each.with_index{|monkey, i|
        name, items, operation, condition, truthy, falsy, times_inspected = monkey
        # puts "monkey #{name} has items #{items}"
        while item = items.shift
            # old = item
            # eval_str = operation.split("=")[1]
            # p eval_str,old
            # item = eval(eval_str)
            item = operation[item]
            # item /= 3
            item %= lcm
            times_inspected += 1
            if item % condition == 0
                monkeys[truthy][1] << item
                # puts "#{name} throws item to #{truthy}"
            else
                monkeys[falsy][1] << item 
                # puts "#{name} throws item to #{falsy}"
            end
        end

        monkeys[i] = [name, items, operation, condition, truthy, falsy, times_inspected]
    }

}
# p monkeys.reverse[0,1].inject:*
p monkeys.transpose[-1].sort
p monkeys.transpose[-1].sort.reverse[0,2].inject:*
p Time.now - T