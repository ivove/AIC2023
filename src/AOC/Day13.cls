Class AOC.Day13 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    set tile = 1
    set len = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        if (line = "") { 
            set map(tile) = $LISTBUILD(len,y - 1)
            set tile = tile + 1
            set y = 0
        }
        else {
            set len = $LENGTH(line)
            for x=1:1:len {
                set c = $EXTRACT(line,x)
                set map(tile,x,y) = c
            }
        }
        set y = y + 1
    }
    set map(tile) = $LISTBUILD(len,y - 1)

    set maxy = y - 1
    set maxTile = tile

    for tile=1:1:maxTile {
        set maxx = $LIST(map(tile),1)
        set maxy = $LIST(map(tile),2)

        set x = 1
        set fnd = 0
        set cont = 1
        //w tile,*9,maxx,*9,maxy,!
        while ((cont) && (fnd = 0) && (x <= maxx)) {
            set x1 = x
            set x2 = x + 1
            set fnd = 1
            if (x2>maxx) { set fnd = 0 }
            //write tile,*9,x,*9,x1,*9,x2,!
            while ((x1 > 0) && (x2 <= maxx) && (fnd = 1)) {
                for y=1:1:maxy {
                    if (map(tile,x1,y) '= map(tile,x2,y)) { set fnd = 0 }
                }
                set x1 = x1 - 1
                set x2 = x2 + 1
            }
            set x = x + 1
        }

        if (fnd) { 
            set result = result + x - 1 
            //w tile,*9,x-1,!
        }
        else {
            set maxx = $LIST(map(tile),1)
            set maxy = $LIST(map(tile),2)

            set y = 1
            set fnd = 0
            set cont = 1
            //w tile,*9,maxx,*9,maxy,!
            while ((cont) && (fnd = 0) && (y <= maxy)) {
                set y1 = y
                set y2 = y + 1
                set fnd = 1
                if (y2>maxy) { set fnd = 0 }
                //write tile,*9,y,*9,y1,*9,y2,!
                while ((y1 > 0) && (y2 <= maxy) && (fnd = 1)) {
                    for x=1:1:maxx {
                        if (map(tile,x,y1) '= map(tile,x,y2)) { set fnd = 0 }
                    }
                    set y1 = y1 - 1
                    set y2 = y2 + 1
                }
                set y = y + 1
            }

            if (fnd) { 
                //w result,*9,tile,*9,y-1,!
                set result = result + ((y - 1) * 100)
            }
        }

        
    }

    return result
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set y = 1
    set tile = 1
    set len = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        if (line = "") { 
            set map(tile) = $LISTBUILD(len,y - 1)
            set tile = tile + 1
            set y = 0
        }
        else {
            set len = $LENGTH(line)
            for x=1:1:len {
                set c = $EXTRACT(line,x)
                set map(tile,x,y) = c
            }
        }
        set y = y + 1
    }
    set map(tile) = $LISTBUILD(len,y - 1)

    set maxy = y - 1
    set maxTile = tile

    for tile=1:1:maxTile {
        set maxx = $LIST(map(tile),1)
        set maxy = $LIST(map(tile),2)

        merge xtile = map(tile)
        
        set orig = ..FindLine(maxx,maxy,.xtile,0)
        w tile,*9,orig,!
        set stop = 0
        set x = $ORDER(xtile(""))
        while ((stop = 0) && (x '= "")) {
            set y = $ORDER(xtile(x,""))
            while ((stop = 0) && (y '= "")) {
                merge ttile = xtile
                set n = "#"
                if (xtile(x,y) = "#") { set n = "." }
                set ttile(x,y) = n
                set add = ..FindLine(maxx,maxy,.ttile,orig)
                if (add '= 0) { 
                    set stop = 1 
                    write tile,*9,x,*9,y,*9,add,*9,ttile(x,y),!
                }
                set result = result + add
                kill ttile
                set y = $ORDER(xtile(x,y))
            }
            set x = $ORDER(xtile(x))
        }

        
        
    }

    return result
}

ClassMethod FindLine(maxx, maxy, tile, orig = 0) As %Integer
{
    set x = 1
    set fnd = 0
    set cont = 1
    set result = 0
    set hor = 0
    set ver = 0
    
    while ((cont) && (fnd = 0) && (x <= maxx)) {
        set x1 = x
        set x2 = x + 1
        set fnd = 1
        if (x2>maxx) { set fnd = 0 }
        
        while ((x1 > 0) && (x2 <= maxx) && (fnd = 1)) {
            for y=1:1:maxy {
                if (tile(x1,y) '= tile(x2,y)) { set fnd = 0 }
            }
            set x1 = x1 - 1
            set x2 = x2 + 1
        }

        if (fnd && (orig = (x))) { set fnd = 0 }

        set x = x + 1
    }

    if (fnd) { 
        set result = x - 1 
    }
    else {
        set y = 1
        set fnd = 0
        set cont = 1
        
        while ((cont) && (fnd = 0) && (y <= maxy)) {
            set y1 = y
            set y2 = y + 1
            set fnd = 1
            if (y2>maxy) { set fnd = 0 }
            while ((y1 > 0) && (y2 <= maxy) && (fnd = 1)) {
                for x=1:1:maxx {
                    if (tile(x,y1) '= tile(x,y2)) { set fnd = 0 }
                }
                set y1 = y1 - 1
                set y2 = y2 + 1
            }
            if (fnd && (orig = (y * 100))) { set fnd = 0 }
            set y = y + 1
        }

        if (fnd) { 
            set result = ((y - 1) * 100)
        }
    }
    return result
}

}
