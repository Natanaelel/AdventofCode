a = open("./input.txt")


x=0
y=0
aim=0
a.each{|i|
    s,d=i.split
    if s=="up"
        aim-=d.to_i
        # y+=d.to_i
        
    end
    if s=="down"
        aim+=d.to_i
        # y-=d.to_i
    end
    if s=="forward"
        x+=d.to_i
        y+=d.to_i*aim
    end
}
p x*y