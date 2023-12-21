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

}
