require "../lib/aoc.rb"

get_input! 11
# test!

str = [*$<]*""
arr = str.split("\n\n")

monkeys = arr.map{|str|
    name, items, operation, condition, truthy, falsy = str.split("\n")
    operation =~ /[*+]/
    right = $'.to_i
    operation_f = $& == "*" ? 
        $' =~ /\d/ ?
        -> x { x * right } :
        -> x { x * x     } :
        -> x { x + right }
    [
        name.find_int,
        items.find_ints,
        operation_f,
        condition.find_int,
        truthy.find_int,
        falsy.find_int,
        0
    ]
}
lcm = monkeys.transpose[3].inject(:*)

10000.times{
    monkeys.map!{|monkey|
        name, items, operation, condition, truthy, falsy, times_inspected = monkey
        while item = items.shift
            # item = operation[item] / 3
            item = operation[item] % lcm
            times_inspected += 1
            monkeys[item % condition == 0 ? truthy : falsy][1] << item
        end

        [name, items, operation, condition, truthy, falsy, times_inspected]
    }

}

p monkeys.transpose[-1].max(2).inject(:*)
