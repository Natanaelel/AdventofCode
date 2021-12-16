a = open("./input.txt")

b = ""
a.read.chomp.chars.each{|c|
    b += "%04b" % c.hex
}

# packet :: ["literal",  [version, type, literal]]
# packet :: ["operator", [version, type, [packet]]]

def f(str)
    version = str[/^.../].to_i(2)
    type = $'[/^.../].to_i(2)
    str = $'
    if type == 4
        s = ""
        while str =~ /^1..../
            s += $&[1..]
            str = $'
        end
        s += str[/^...../][1..]
        return ["literal", [version, type, s.to_i(2)]], $'
    end
    type_id = str[/^./].to_i
    str = $'
    if type_id == 0
        len = str[/^.{15}/].to_i(2)
        str = $'
        subpackets = []
        while len > 0
            subpacket, rest = f(str)
            subpackets << subpacket
            len -= str.size - rest.size
            str = rest
        end
        return ["operator", [version, type, subpackets]], str
    end
    num_packets = str[/^.{11}/].to_i(2)
    str = $'
    subpackets = []
    num_packets.times{
        subpacket, rest = f(str)
        subpackets << subpacket
        str = rest
    }
    return ["operator", [version, type, subpackets]], str
end

packet, rest = f(b)

packets = []

f = -> packet {
    return unless packet
    packets << packet
    packet[1][2].each &f if packet[0] == "operator"
}
f[packet]

p packets.map{|symbol, (version, type, value)| version}.sum

parse = -> packet {
    return packet[1][2] if packet[0] == "literal"

    arr = packet[1][2].map &parse

    return case packet[1][1]
    when 0; "("+arr*" + "+")"
    when 1; "("+arr*" * "+")"
    when 2; "["+arr*" , "+"].min"
    when 3; "["+arr*" , "+"].max"
    when 5; "("+arr*" > "+" ? 1 : 0)"
    when 6; "("+arr*" < "+" ? 1 : 0)"
    when 7; "("+arr*" == "+" ? 1 : 0)"
    end
}

parsed = parse[packet]
p parsed
p eval parsed