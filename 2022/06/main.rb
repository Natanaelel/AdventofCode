require "../lib/aoc.rb"

get_input! 6
# test!

p gets.each_cons(14).index(&:uniq?)+14
