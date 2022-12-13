score = 0
$<.each{|line|
    a,b=line.split

    # score += 1 if a == "A"
    # score += 2 if a == "B"
    # score += 3 if a == "C"
    p score
    # i = "XYZ".index b
    i = "ABC".index a
    # score += (i-a+1)%3 * 3
    score += (i-1)%3+1 if b == "X"
    score += 0 if b == "X"
    score += (i)%3+1 if b == "Y"
    score += 3 if b == "Y"
    score += (i+1)%3+1 if b == "Z"
    score += 6 if b == "Z"
    p score
}
p score