r=*?a..?g
p open("./input.txt").sum{|line|
    a,b=line.split(?|)
    h=r.map{|k|[k,r]}.to_h

    a.split{|x|%w"cf acf bcdf adg abfg adgbcef"[x.size-2].chars{|c|h[c]&=x.chars}}

    m = h.values.inject(:product).map(&:flatten).find{|x|r&x==r}.join

    b.split.map{|num|
        %w"abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg".index num.tr(m,"a-g").chars.sort.join
    }.join.to_i
}
