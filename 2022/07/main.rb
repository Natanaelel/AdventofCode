require "../lib/aoc.rb"

get_input! 7
test!


dir = {}
s = nil
is_dirs = []
one_level_dir = {}

current_dir = ["/"]

tree = {"/" => {}}

cdf = -> line {
    dollar, cd, where = line.split
    # p ["$$$",dollar, cd, where]
    # p current_dir
    if where == "/"
        puts "don't move"
         # don't move
    elsif where == ".." # move back
        current_dir.pop
        puts "pop #{where}"
    else
        current_dir.push where
        puts "push #{where}"
        tree[where] = {}
    end
    puts "current_dir"
    p current_dir
}
ls = -> line {
    dirs = []
    while gets =~ /^\d|^dir/
        if ~/^dir/
            # is_dirs[current_dir] ||= []
            is_dirs << $_.split[1]
            one_level_dir[current_dir[-1]] ||= []
            one_level_dir[current_dir[-1]] << $_.split[1]
            # tree[$_.split[1]] = {}
            str = "tree" + (current_dir + [$_.split[1]]).map{|x|"['#{x}']"}.join + " = {}" #+ $_.split[0]
            eval str
            next
        end
            
        dir[current_dir + [$_.split[1]]] = $_.split[0].to_i
        one_level_dir[current_dir[-1]] ||= []
        one_level_dir[current_dir[-1]] << $_.split[0].to_i
        p current_dir + [$_.split[1]]
        str = "tree" + (current_dir + [$_.split[1]]).map{|x|"['#{x}']"}.join + " = " + $_.split[0]
        # str += "\ntree" + current_dir.map{|x|"['#{x}']"}.join + " << " + $_.split[0]
        p str
        eval str rescue p "error",str
        # dir[current_dir + [$_.split[1]]] = $_.split[0].to_i
        # dir[current_dir] << $_.s
    end
    s = $_
}
loop{
    s = gets unless s
    break unless s
    puts "s: #{s}"
    case s.split[0]
    when "$"
        if s.split[1] == "ls"
            ls[s]
            p ["s",s]
        else
            puts "change dir: #{s}"
            cdf[s]
            # p ["cds",s]
            s=nil
        end
        # p s.split
        redo
    else
        p "what? #{$_}"
    end
}


# p current_dir
# p dir
# p dir.values.sum
cache = {}
visited = []
dir_sum = -> dirx {
    return 0 if visited.include?(dirx)
    visited << dirx
    # p visited
    return cache[dirx] if cache[dirx]
    cache[dirx] = one_level_dir[dirx].sum{|x|
        if Integer === x
            x
        else
            exit 1 if x == nil
            cache[x] = dir_sum[x]
        end
    }
}
# p is_dirs

puts "getting sum"
p *dir
p is_dirs.map{|dir|
    dir_sum[dir]
}.select{|x|x<=100000}.sum
# p dir.select{|k,v|
#     is_dirs.include?(k[-1])
# }
sums = []
sums2 = {}
tree_sum = -> root, path = [] {
    res = root.sum{|k,v|
        Integer === v ? v : sums2[path + [k]] = tree_sum[v, path + [k]]
    }
    sums << res
    res
}
p total_sum = tree_sum[tree]
to_remove = total_sum - 40000000
p to_remove
# p sums
p sums2.select{|k,v|v <= 100000}.min_by{|k,v|v}
