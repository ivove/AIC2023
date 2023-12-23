Class AOC.Day23 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    set maxx = 0
    set sy = 1
    set sx = 0
    
    Set y = 1
    While ('..TestFile.AtEnd){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len > maxx) { set maxx = len }
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            if ((y = 1) && (c = ".")) { set sx = x }
            set map(x,y) = c
        }
        set y = y + 1
    }
    set maxy = y - 1
    set ex = 0
    for x=1:1:maxx {
        if map(x,maxy) = "." { set ex = x }
    }

    //do ..Step(sx,sy,maxy,"","",.p,.map)
    do ..Step3(sx,sy,maxy,maxy,"","",.p,.map)

    set result = $ORDER(p(""),-1)
    //zw p
    w !

    return result
}

Method Step3(sx, sy, maxx, maxy, visited, path, paths, map)
{
    set found = 0
    while 'found {
        set path = path_map(sx,sy)
        set visited = visited_("|"_sx_"*"_sy_"|")
        if ((sx = maxx) && (sy = maxy)) {
            set found = 1
            set paths($LENGTH(path)) = path
        } else {
            if "^v<>" [ map(sx,sy) {
                set dx = 0
                set dy = 0
                if (map(sx,sy) = "^") { set dy = -1 }
                ElseIf (map(sx,sy) = "v") {set dy = 1 }
                ElseIf (map(sx,sy) = ">") {set dx = 1 }
                else { set dx = -1 }
                set nx = sx + dx
                set ny = sy + dy
                if ($DATA(map(nx,ny)) && (visited '[ ("|"_nx_"*"_ny_"|")) && (map(nx,ny) '= "#")) {
                    set sx = nx
                    set sy = ny
                } else { set found = 1}
            } else {
                k atl
                for d=$lb(1,0),$lb(-1,0),$lb(0,-1),$lb(0,1) {
                    set dy=$LIST(d,2)
                    set dx = $LIST(d,1)
                    set nx = sx + dx
                    set ny = sy + dy
                    if ($DATA(map(nx,ny)) && (visited '[ ("|"_nx_"*"_ny_"|")) && (map(nx,ny) '= "#")) {
                        set atl = $get(atl) + 1
                        set atl(atl)=$lb(nx,ny)
                    }
                }
                if $get(atl) = 1 {
                    set sx = $LIST(atl(1),1)
                    set sy = $LIST(atl(1),2)
                } elseif +$get(atl) = 0 { set found = 1 }
                else {
                    for i=1:1:atl {
                        do ..Step3($LIST(atl(i),1),$LIST(atl(i),2),maxx,maxy,visited,path,.paths,.map)
                    }
                }

            }
        }
    }
}

ClassMethod Step2(sx, sy, maxy, map, p)
{
    set found = 0
    set edge(sx,sy) = ""
    set p(sx,sy) = 0
    while 'found {
        set cedge = 0
        set x = $ORDER(edge(""))
        while x '= "" {
            set y = $ORDER(edge(x,""))
            while y '= "" {
                kill edge(x,y)
                write y,*9,x,*9,map(x,y),*9,$get(p(x,y)),!
                if (y = maxy) && (map(x,y) = ".") { set found = 1 }
                else {
                    if "^v<>" [ map(x,y) {
                        set dx = 0
                        set dy = 0
                        if (map(x,y) = "^") { set dy = -1 }
                        ElseIf (map(x,y) = "v") {set dy = 1 }
                        ElseIf (map(x,y) = ">") {set dx = 1 }
                        else { set dx = -1 }
                        if $DATA(map(x+dx,y+dy)) && ($get(p(x+dx,y+dy)) < (p(x,y)+1)) {
                            set edge(x+dx,y+dy) = ""
                            set cedge = cedge + 1
                            set p(x+dx,y+dy) = p(x,y) + 1
                        }
                    } elseif map(x,y) = "." {
                        for d=$lb(1,0),$lb(-1,0),$lb(0,-1),$lb(0,1) {
                            set dy=$LIST(d,2)
                            set dx = $LIST(d,1)
                            if $DATA(map(x+dx,y+dy)) && ($get(p(x+dx,y+dy)) < (p(x,y)+1)) {
                                set edge(x+dx,y+dy) = ""
                                set cedge = cedge + 1
                                set p(x+dx,y+dy) = p(x,y) + 1
                            }
                        }
                    }
                }
                set y = $ORDER(edge(x,y))
            }
            set x = $ORDER(edge(x))
        }
        if cedge > 1 {
            kill edge 
            set found = 1
            set x = $ORDER(edge(""))
            while x '= "" {
                set y = $ORDER(edge(x,""))
                while y '= "" {
                    do ..Step2(x,y,maxy,.map,.p)
                    set y = $ORDER(edge(x,y))
                }
                set x = $ORDER(edge(x))
            }
        }
    }
}

ClassMethod Step(cx, cy, maxy, path, visited, paths, map)
{
    //w path,!
    set current = map(cx,cy)
    if (current '= "#") {
        set path = path_current
        set visited = visited_("|"_cx_"*"_cy_"|")
        if ((current = ".") && (cy = maxy)) {
            set paths($LENGTH(path)) = path
        } else {
            if (current = ".") {
                if $DATA(map(cx+1,cy)) && ('(visited[("|"_(cx+1)_"*"_cy_"|"))) { 
                    do ..Step(cx+1,cy,maxy,path,visited,.paths,.map)
                }
                if $DATA(map(cx-1,cy)) && ('(visited[("|"_(cx-1)_"*"_cy_"|"))) { 
                    do ..Step(cx-1,cy,maxy,path,visited,.paths,.map)
                }
                if $DATA(map(cx,cy+1)) && ('(visited[("|"_(cx)_"*"_(cy+1)_"|"))) { 
                    do ..Step(cx,cy+1,maxy,path,visited,.paths,.map)
                }
                if $DATA(map(cx,cy-1)) && ('(visited[("|"_(cx)_"*"_(cy-1)_"|"))) { 
                    do ..Step(cx,cy-1,maxy,path,visited,.paths,.map)
                }
            } else {
                set dx = 0
                set dy = 0
                if (current = "^") { set dy = -1 }
                ElseIf (current = "v") {set dy = 1 }
                ElseIf (current = ">") {set dx = 1 }
                else { set dx = -1 }
                if $DATA(map(cx+dx,cy+dy)) && ('(visited[("|"_(cx+dx)_"*"_(cy+dy)_"|"))) { 
                    do ..Step(cx+dx,cy+dy,maxy,path,visited,.paths,.map)
                }
            }
        }
    }
}

}
