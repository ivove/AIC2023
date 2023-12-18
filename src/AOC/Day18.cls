Class AOC.Day18 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    set x = 1
    set y = 1
    set maxx = 0
    set maxy = 0
    set miny = 999999
    set minx = 999999
    set trench(x,y) = "#"

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set dir = $PIECE(line," ",1)
        set len = $PIECE(line," " ,2)

        set dx = 0
        set dy = 0
        if (dir = "U") { set dy = -1 }
        elseif (dir = "D") { set dy = 1 }
        elseif (dir = "R") { set dx = 1 }
        elseif (dir = "L") { set dx = -1 }

        for i=1:1:len {
            set x = x + dx
            set y = y + dy
            set trench(x,y) = "#"
            set itrench(y,x) = "#"
        }

        if (x > maxx) { set maxx = x }
        if (y > maxy) { set maxy = y }
        if (y < miny) { set miny = y }
        if (x < minx) { set minx = x }

    }

    do ..Show(minx,miny,maxx,maxy,.trench)
    
    set xx = $ORDER(itrench(miny,""))
    w minx,*9,xx,!

    do ..Dig(xx+1,miny+1,.trench)

    w !,!
    h 1
    do ..Show(minx,miny,maxx,maxy,.trench)

    for x=minx:1:maxx {
        for y=miny:1:maxy {
            if ($get(trench(x,y),".") = "#" ) {
                set result = result + 1
            }
        }
    }

    Return result
}

ClassMethod Dig(x, y, map)
{
    set edge(x,y) = ""
    set tx = $ORDER(edge(""))
    while tx '= "" {
        set ty = $ORDER(edge(tx,""))
        while ty '= "" {
            set map(tx,ty) = "#"
            set visited(tx,ty) = ""
            for dx=-1:1:1{
                for dy=-1:1:1 {
                    if '$d(visited(tx+dx,ty+dy)) {
                        set edge(tx+dx,ty+dy) = ""
                    }
                }
            }
            kill edge(tx,ty)
            set ty = $ORDER(edge(tx,ty))
        }
        set tx = $ORDER(edge(tx))
    }
}

ClassMethod Show(minx, miny, maxx, maxy, trench)
{
    Set file=##class(%File).%New("c:\AOC2023\out\day18"_$h_".txt")
    Do file.Open("WSN")
    Do file.WriteLine("This is a line of text")
    for y=miny:1:maxy {
        set line = ""
        for x=minx:1:maxx {
            if $GET(trench(x,y))'="" {
                set line = line_$get(trench(x,y),".")
            } else {
                set line = line_"."
            }
        }
        Do file.WriteLine(line)
    }
    do file.Close()
}

ClassMethod IsFree(x, y, boundx, boundy, map, visited)
{
    kill visited
    kill edge
    Set free = 0
    set done = 0
    set edge(x,y) = ""
    while ((free = 0) && (done = 0)) {
        set x = $ORDER(edge(""))
        while (x '= "") {
            set y = $ORDER(edge(x,""))
            while (y '= "") {
                for dx=-1:1:1 {
                    for dy=-1:1:1 {
                        set nx = x+dx
                        set ny = y+dy
                        If (((nx)<1) || ((nx)>boundx) || ((ny)<1) || ((ny)>boundy)) {
                            Set free = 1
                        }
                        else {
                            If ('$DATA(visited(nx,ny))) {
                                Set n = $GET(map(nx,ny),".")
                                If ((n = ".") && (free = 0)) {
                                    Set visited(x,y)=$get(map(x,y),".")
                                    set edge(nx,ny)=""
                                }
                            }
                        }
                    }
                }
                set visited(x,y) = $get(map(x,y),".")
                kill edge(x,y)
                set y = $ORDER(edge(x,y))
            }
            set x = $ORDER(edge(x))
        }
        if ('$DATA(edge)) { set done = 1 }
    }
    //write boundx,*9,boundy,!
    //zw visited
    Return free
}

}
