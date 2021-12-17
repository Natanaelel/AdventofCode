a = open("./input.txt")

xmin, xmax, ymin, ymax = a.read.scan(/-?\d+/).map(&:to_i)


works = -> xv,yv {
    highest = 0
    x=0
    y=0
    (0..200).any?{
        x += xv
        y += yv
        yv -= 1
        xv -= xv <=> 0
        
        highest = [highest, y].max
        return if x > xmax || y < ymin
        x >= xmin && y <= ymax
    }
}

p ymin * (ymin + 1) / 2

p (0..xmax).sum{|x|
    (ymin..ymax**2/2).count{|y|
        works[x, y]
    }
}
