Class AOC.Day8 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 

    Set instruction = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
    set len = $LENGTH(instruction)
    Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"") //read blank line

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set from = $PIECE(line," = ",1)
        set l = $PIECE($PIECE(line,"(",2),",",1)
        set r = $PIECE($PIECE(line,", ",2),")",1)
        set map(from) = $LISTBUILD(l,r)
    }

    zw map
    set loc = "AAA"

    while loc '= "ZZZ" {
        set i = 1
        while ((i <= len) && (loc '= "ZZZ")) {
            set dir = $EXTRACT(instruction,i)
            set tile = map(loc)
            if (dir = "R") { set loc = $LIST(tile,2) }
            Else { set loc = $LIST(tile,1) }
            set result = result + 1
            set i = i + 1
        }
    }

    return result
}

Method Part2() As %Integer
{
    Set result = 0 

    Set instruction = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
    set len = $LENGTH(instruction)
    Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"") //read blank line

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set from = $PIECE(line," = ",1)
        set l = $PIECE($PIECE(line,"(",2),",",1)
        set r = $PIECE($PIECE(line,", ",2),")",1)
        set map(from) = $LISTBUILD(l,r)
    }

    set loc = $ORDER(map(""))
    while (loc '= "") {
        if ($EXTRACT(loc,3) = "A") { set current(loc) = map(loc) }
        set loc = $ORDER(map(loc))
    }

    set cont = 1

    while cont = 1 {
        set i = 1
        while ((i <= len) && (cont = 1)) {
            set dir = $EXTRACT(instruction,i)
            set xdir = 1
            if (dir = "R") { set xdir = 2 }

            set stop = 1
            set loc = $ORDER(current(""),1,tile)
            while loc '= "" {
                set next = $LIST(tile,xdir) 
                set nxt(next) = map(next)
                if ($EXTRACT(next,3) '= "Z") { set stop = 0 }
                set loc = $ORDER(current(loc),1,tile)
            }

            kill current
            merge current = nxt
            kill nxt

            if (stop = 1) { set cont = 0 }

            set result = result + 1
            set i = i + 1
        }
    }

    return result
}

ClassMethod GreatestCommonDivisor(a, b) As %Integer
{
    
    while (a '= b)    {
        if (a>b) { set a = a - b }
        else { set b = b - a }
    }
    quit a
}

Method Part2b() As %Integer
{
    Set result = 0 

    Set instruction = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
    set len = $LENGTH(instruction)
    Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"") //read blank line

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set from = $PIECE(line," = ",1)
        set l = $PIECE($PIECE(line,"(",2),",",1)
        set r = $PIECE($PIECE(line,", ",2),")",1)
        set map(from) = $LISTBUILD(l,r)
    }

    set loc = $ORDER(map(""))
    while (loc '= "") {
        if ($EXTRACT(loc,3) = "A") { set current(loc) = map(loc) }
        set loc = $ORDER(map(loc))
    }

    set start = $ORDER(current(""))
    while (start '= "") {
        set c = start
        set steps = 0
        set cont = 1
        while cont {
            set i = 1
            while ((i <= len) && (cont = 1)) {
                set dir = $EXTRACT(instruction,i)
                set tile = map(c)
                if (dir = "R") { set c = $LIST(tile,2) }
                Else { set c = $LIST(tile,1) }
                set i = i + 1
                set steps = steps + 1
                if ($EXTRACT(c,3) = "Z") { 
                    set pos(steps) = 0 
                    set cont = 0
                }
            }
        }
        set start = $ORDER(current(start))
    }

    set cont = 1
    set max = $ORDER(pos(""))
    set nmax = $ORDER(pos(max))
    while (nmax '=""){
        set max = (max * nmax)/..GreatestCommonDivisor(max,nmax)
        set nmax = $ORDER(pos(nmax))
    }
    set result = max

    return result
}

}
