prio = -> c {
    c =~ /[a-z]/ ? c.ord - 96 : c.ord - 64+26
}
sc = 0
$<.each_slice(3).map{|lines|
    u = lines.map(&:chars).inject(:&)
    u=u[0]
    sc+=prio.call u
    # sc += prio.call u = (line[0,line.size / 2].chars & line[line.size / 2, line.size / 2,].chars)[0]
    p u,prio.(u)
}
p sc