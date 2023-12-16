Class AOC.Day16 Extends AOC.Base
{

Method Part1() As %Integer
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
            set map(x,y) = c
        }
        set y = y + 1
    }
    set maxy = y-1

    //d ..Show(.map,.visited)
    w !,!

    do ..Step(1,1,"R",maxx,maxy,.map,.visited)

    // ..Show(.map,.visited)

    set x = $ORDER(visited("")) 
    while (x '= "") {
        set y = $ORDER(visited(x,""))
        while (y '= "") {
            set result = result + 1
            set y = $ORDER(visited(x,y))
        }
        set x = $ORDER(visited(x))
    }

    Return result
}

ClassMethod Show(map, visited)
{
    set x = $ORDER(map("")) 
    while (x '= "") {
        set y = $ORDER(map(x,""))
        while (y '= "") {
            if ('$DATA(visited(x,y))) {
                w map(x,y)
            }
            else { w "#"}
            set y = $ORDER(map(x,y))
        }
        w !
        set x = $ORDER(map(x))
    }
}

ClassMethod Step(cx, cy, dir, maxx, maxy, map, visited)
{
    if ((cx <= maxx) && (cy <= maxy) && (cx > 0) && (cy > 0) && ($GET(visited(cx,cy)) '[ dir)) {
        set dx = 0
        set dy = 0
        if (dir = "D") { set dy = 1 }
        ElseIf (dir = "U") { set dy = -1 }
        ElseIf (dir = "R") { set dx = 1 }
        ElseIf (dir = "L") { set dx = -1 }
        set visited(cx,cy) = $get(visited(cx,cy))_dir
        if $DATA(map(cx+dx,cy+dy)) {
            set nc = map(cx+dx,cy+dy)
        

            if (nc = ".") {
                do ..Step(cx+dx,cy+dy,dir,maxx,maxy,.map,.visited)
            }
            ElseIf (nc = "/") {
                if (dir = "U") { do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited) }
                elseif (dir = "D") { do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited) }
                elseif (dir = "L") { do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited) }
                else { do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited) }
            }
            elseif (nc = "\") {
                if (dir = "U") { do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited) }
                elseif (dir = "D") { do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited) }
                elseif (dir = "L") { do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited) }
                else { do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited) }
            }
            elseif (nc = "|") {            
                if (dir = "U") { do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited) }
                elseif (dir = "D") { do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited) }
                elseif (dir = "L") { 
                    do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited)
                    do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited)
                }
                else { 
                    do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited) 
                    do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited) 
                }
            }   
                elseif (nc = "-") {
                if (dir = "L") { do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited) }
                elseif (dir = "R") { do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited) }
                elseif (dir = "D") { 
                    do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited)
                    do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited)
                }
                else { 
                    do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited) 
                    do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited) 
                }
            }
        }
    }
}

}
