# convenience-functions for aoc

AOC_COOKIE = "SESSION_TOKEN"

require "set" # for search algs

class String
    def fill
        gsub(/(.)-(.)/){
            $1 < $2 ? [*$1..$2]*"" : [*$2..$1]*""
        }
    end
    
    alias split_string split
    def split(arg = $;, side = :left) # size :left | :right | :skip
        if Integer === arg
            if arg >= 0
                chars.each_slice(arg).map(&:join)
            else
                num_greater = (size - 1) % -arg + 1 # number of resultign elements whoose length is larger than others (by 1)
                start_offset = -> i {
                    case side
                    when :left
                        i < num_greater ? 0 : 1
                    when :right
                        (-arg) - i >= num_greater ? -1 : 0
                    else
                        0
                    end
                }
                length_offset = -> i {
                    case side
                    when :left
                        i < num_greater ? 1 : 0
                    when :right
                        (-arg) - i > num_greater ? 0 : 1
                    else
                        0
                    end
                }
                start = -> i {
                    case side
                    when :left
                        off_i = size % -arg
                        [off_i, i].min + i * (size / -arg)
                    when :right
                        off_i = size % -arg
                        [0,i-(-arg)+off_i].max + i * (size / -arg)
                    else
                        i * (size / -arg)
                    end
                }
                len = -> i {
                    case side
                    when :left
                        off_i = size % -arg
                        off = i < off_i ? 1 : 0
                        size / -arg + off
                    when :right
                        off_i = size % -arg
                        off = (-arg) - i-1 < off_i ? 1 : 0
                        size / -arg + off
                    else
                        size / -arg
                    end
                }
                
                slice_len = (size.to_f / -arg).ceil - 1
                slice_len = size / -arg
                arg.abs.times.map{|i|
                    self[start.(i), len.(i)]
                }
            end
        else
            split_string arg
        end
    end

    def ints = split.map(&:to_i)
    def find_ints = scan(/-?\d+/).ints
    def find_int = self[/-?\d+/].to_i
    
    def direction(directions = "RLUD")
        index = directions.index(self)
        return [0, 0] unless index
        return [
            [ 1, 0],
            [-1, 0],
            [ 0,-1],
            [ 0, 1]
        ][index] || [0, 0]
    end
    def vec(directions = "RLUD")
        direction(directions).vec
    end

    alias old_index index
    def index(*args, &b)
        if b
            find_index(&b)
        else
            old_index(*args)
        end
    end
end

module Enumerable
    def split(arg, side = :left) # size :left | :right | :skip
        if arg >= 0
            each_slice(arg).to_a
        else
            num_greater = (size - 1) % -arg + 1 # number of resultign elements whoose length is larger than others (by 1)
            start_offset = -> i {
                case side
                when :left
                    i < num_greater ? 0 : 1
                when :right
                    (-arg) - i >= num_greater ? -1 : 0
                else
                    0
                end
            }
            length_offset = -> i {
                case side
                when :left
                    i < num_greater ? 1 : 0
                when :right
                    (-arg) - i > num_greater ? 0 : 1
                else
                    0
                end
            }
            start = -> i {
                case side
                when :left
                    off_i = size % -arg
                    [off_i, i].min + i * (size / -arg)
                when :right
                    off_i = size % -arg
                    [0,i-(-arg)+off_i].max + i * (size / -arg)
                else
                    i * (size / -arg)
                end
            }
            len = -> i {
                case side
                when :left
                    off_i = size % -arg
                    off = i < off_i ? 1 : 0
                    size / -arg + off
                when :right
                    off_i = size % -arg
                    off = (-arg) - i-1 < off_i ? 1 : 0
                    size / -arg + off
                else
                    size / -arg
                end
            }
            
            slice_len = (size.to_f / -arg).ceil - 1
            slice_len = size / -arg
            arg.abs.times.map{|i|
                self[start.(i), len.(i)]
            }
        end
    end

    def index(*a, **b, &c) = to_a.index(*a, **b, &c)
    def uniq? = !dup.uniq!
    def index2(*a, &b)
        if a.size == 0

        elsif a.size == 1
            b = It == a[0]
        else
            throw ArgumentError.new("wrong number of arguments (given #{a.size}, expected 0 - 1)")
        end
        x = nil
        y = index{|row|
            x = row.index(&b)
        }
        [x, y]

    end
    def indices(*a, &b)
        b = It == a if a.size == 1
        each_index.select{|i|
            b.call self[i]
        }
    end
    def sorted?()
        ## needs testing
        # b ||= -> x{x}
        # return true if self.size == 0
        # last = b.(self[0])
        # self[1..].all?{|x|
        #     1 != (last <=> (last = b.(x)))
        # }
        self == self.sort
    end
end
class Array
    def sizes
        map &:size
    end

    def range
        self[0] .. self[1]
    end
    
    def intersect?(other)
        self & other != []
    end

    def ints = map(&:to_i)

    def vec
        Vec.new *self
    end

    def **(num)
        num.times.flat_map{map(&:dup)}
    end
    alias >> prepend
end

class String
    include Enumerable
    alias each each_char
end

class Range
    def intersect?(other)
        cover?(other.begin) || cover?(other.end) || other.cover?(self.begin) || other.cover?(self.end)
    end
    def &(other)
        to_a & other.to_a
    end
    def |(other)
        to_a | other.to_a
    end
    def -(other)
        to_a - other.to_a
    end
    def <(other) = self.begin > other.begin && self.end < other.end
    def <=(other) = self.begin >= other.begin && self.end <= other.end
    def >(other) = self.begin < other.begin && self.end > other.end
    def >=(other) = self.begin <= other.begin && self.end >= other.end
    
end


def get_input!(day, file_path: "in", log: false, force: false)
    if Integer === day && !((1..25) === day)
        puts "invalid day number, must be 1..25" if log
    end
    if !force && File.exist?(file_path)
        if File.zero?(file_path)
            puts "empty file, downloading..." if log
        else
            puts "reading from file" if log
            return $stdin = File.open(file_path)
        end
    end
    puts "downloading input for day #{day}" if log
    system("curl \"https://adventofcode.com/#{2022}/day/#{day}/input\" -b session=#{AOC_COOKIE} > #{file_path}")
    return $stdin = File.open(file_path)
end

def test!(file_path = "test")
    $stdin = File.open(file_path)
end

def p1!(ans)
    out = open "out", "a"
    out.puts "p1:\n#{ans}"
    out.close
end
def p2!(ans)
    out = open "out", "a"
    out.puts "p2:\n#{ans}"
    out.close
end


class Vec
    include Enumerable
    def initialize(*arr)
        @arr = arr
    end
    def each(*args, &block)
        @arr.each(*args, &block)
        
    end
    def +(other) = @arr.zip(other.arr).map{|a, b| a + b }.vec
    def -(other) = @arr.zip(other.arr).map{|a, b| a - b }.vec
    
    def arr = @arr
    alias to_a arr

    def x = @arr[0]
    def y = @arr[1]
    def z = @arr[2]
    def xy = [x, y]
    def yx = [y, x]

    def x=(val) @arr[0] = val end
    def y=(val) @arr[1] = val end
    def z=(val) @arr[2] = val end

    def ==(other)
        Vec === other && arr == other.arr
    end
    alias eql? ==
    def hash
        @arr.hash
    end
    def dup
        arr.dup.vec
    end

    def [](*args)
        arr.[](*args)
    end
    def []=(*args, val)
        arr.[]=(*args, val)
    end

    def inspect
        "vec(#{@arr.map(&:inspect)*", "})"
    end

    
end

class Search
    def self.BFS_grid(grid:, start:, get_neighbor_pos:, get:, goal:)
        
        width = grid[0].size
        height = grid.size

        in_grid = -> pos {
            pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height
        }

        queue = [[start, []]]
        explored = Set.new
        
        until queue.empty?
            # take the first position and path from the queue
            pos, path = queue.shift
            
            # check if the position is the goal
            # if it is, return the path as this will be the shortest path
            return path if goal.(pos)
            
            # otherwise, explore all possible moves from the current position
            # and add them to the queue if they have not been explored before
            get_neighbor_pos.(pos).each do |neighbor_pos|
                next unless in_grid.(neighbor_pos)
                next if explored.include?(neighbor_pos)
                queue << [neighbor_pos, path + [neighbor_pos]]
                explored << neighbor_pos
            end
        end
    end
    def self.neighbors4(pos)
        [
            [-1, 0],
            [ 1, 0],
            [ 0,-1],
            [ 0, 1]
        ].map{|delta|
            pos + delta.vec
        }
    end
    def self.neighbors_in_grid(width, height)
        -> pos {
            pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height
        }
    end
end

class << It = BasicObject.new
    undef ==, !=, equal?
    def method_missing(...) = -> val { val.__send__(...) }
end