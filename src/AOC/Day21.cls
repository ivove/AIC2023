Class AOC.Day21 Extends AOC.Base
{

Method Part1(number) As %Integer
{
    Set result = 0 
    set maxx = 0

    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len > maxx) { set maxx = len }
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            if c = "S" {
                set sx = x
                set sy = y
                set c = "."
            }
            set map(x,y) = c
        }
        set y = y + 1
    }
    set maxy = y - 1

    do ..Steps(sy,sx,number,.map,.pos)

    set x = $ORDER(pos(""))
    while x '= "" {
        set y = $ORDER(pos(x,""))
        while y '= "" {
            set result = result + 1
            set y = $ORDER(pos(x,y))
        }
        set x = $ORDER(pos(x))
    }

    return result
}

ClassMethod Steps(sx, sy, number, map, pos)
{
    kill pos
    set edge(sx,sy) = ""
    for i=1:1:number {
        kill nedge
        set x = $ORDER(edge(""))
        while x '= "" {
            set y = $ORDER(edge(x,""))
            while y '= "" {
                if $DATA(map(x-1,y)) && (map(x-1,y) = ".") { set nedge(x-1,y) = "" }
                if $DATA(map(x+1,y)) && (map(x+1,y) = ".") { set nedge(x+1,y) = "" }
                if $DATA(map(x,y-1)) && (map(x,y-1) = ".") { set nedge(x,y-1) = "" }
                if $DATA(map(x,y+1)) && (map(x,y+1) = ".") { set nedge(x,y+1) = "" }
                set y = $ORDER(edge(x,y))
            }
            set x = $ORDER(edge(x))
        }
        kill edge
        merge edge = nedge
    }
    merge pos = edge
}

Method Part2(number) As %Integer
{
    Set result = 0 
    set maxx = 0

    
    Set y = 1
    While ('..TestFile.AtEnd){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len > maxx) { set maxx = len }
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            if c = "S" {
                set sx = x
                set sy = y
                set c = "."
            }
            set map(x,y) = c
        }
        set y = y + 1
    }
    set maxy = y - 1

    do ..Steps2(sy,sx,maxx,maxy,number,.map,.pos)

    set x = $ORDER(pos(""))
    while x '= "" {
        set y = $ORDER(pos(x,""))
        while y '= "" {
            set result = result + 1
            set y = $ORDER(pos(x,y))
        }
        set x = $ORDER(pos(x))
    }

    return result
}

ClassMethod Steps2(sx, sy, maxx, maxy, number, map, pos)
{
    kill pos
    set edge(sx,sy) = 0
    set pos(sx,sy) = 0
    for i=1:1:number {
        set x = $ORDER(edge(""))
        while x '= "" {
            set y = $ORDER(edge(x,""))
            while y '= "" {
                kill edge(x,y)
                set xx = ..Overflow(x,maxx)
                set yy = ..Overflow(y,maxy)
                set xm = ..Overflow(x-1,maxx)
                set ym = ..Overflow(y-1,maxy)
                set xp = ..Overflow(x+1,maxx)
                set yp = ..Overflow(y+1,maxy)
                if (map(xm,yy) = ".") { 
                    if '$DATA(pos(x-1,y)) {
                        set nedge(x-1,y) = i 
                        set pos(x-1,y) = i 
                    }
                }
                if (map(xp,yy) = ".") { 
                    if '$DATA(pos(x+1,y)) {
                        set nedge(x+1,y) = i 
                        set pos(x+1,y) = i 
                    }
                }
                if (map(xx,ym) = ".") { 
                    if '$DATA(pos(x,y-1)) {
                        set nedge(x,y-1) = i 
                        set pos(x,y-1) = i 
                    }
                }
                if (map(xx,yp) = ".") { 
                    if '$DATA(pos(x,y+1)) {
                        set nedge(x,y+1) = i 
                        set pos(x,y+1) = i 
                    }
                }
                set y = $ORDER(edge(x,y))
            }
            set x = $ORDER(edge(x))
        }
        kill edge
        merge edge = nedge
    }
}

ClassMethod Overflow(x, max) As %Integer
{
    if ((x < 1)) { set x = (x # max)  }
    ElseIf (x > max) { set x = x # max }
    if (x = 0) { set x = max }
    return x
}

}
