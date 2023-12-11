Class AOC.Day11 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0

    set y = 1
    set maxx = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set maxx = len
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            set map(x,y) = c
        }
        if (line '[ "#") {
            set y = y + 1
            for x=1:1:len {
                set map(x,y) = "."
            }
        }
        set y = y + 1
    }
    set maxy = y

    for x=1:1:maxx {
        set fnd = 0 
        set y = 1
        while ((y<maxy) && (fnd = 0)) {
            if (map(x,y) = "#") { set fnd = 1 }
            set y = y + 1
        }
        if (fnd = 0) {
            set xx = x + 0.5
            for y=1:1:(maxy-1) {
                set map(xx,y) = "."
            }
        }
    }

    do ..CorrectMap(.map,.nmap)

    set x = $ORDER(nmap(""))
    while x '= "" {
        set y = $ORDER(nmap(x,""))
        while y '= "" {
            set c = nmap(x,y)
            if (c = "#") {
                set gal = $get(gal) + 1
                set gal(gal) = $LISTBUILD(x,y)
            }
            set y = $ORDER(nmap(x,y))
        }
        set x = $ORDER(nmap(x))
    }

    /*do ..ShowMap(.nmap)
    zw nmap*/

    for i=1:1:gal {
        for j=1:1:gal {
            if (i '= j) {
                set gi = gal(i)
                set gix = $LIST(gi,1)
                set giy = $LIST(gi,2) 
                set gj = gal(j)
                set gjx = $LIST(gj,1)
                set gjy = $LIST(gj,2)
                set x1 = gix_","_giy_"x"_gjx_"x"_gjy
                set x2 = gjx_","_gjy_"x"_gix_"x"_giy
                if ('$DATA(done(x1)) && '$DATA(done(x2))) {
                    set dist = $ZABS(gix - gjx) + $ZABS(giy - gjy)

                    //w i,"(",gix,"-",giy,")",*9,j,"(",gjx,"-",gjy,")",*9,dist,!

                    set result = result + dist
                    set done(x1) = ""
                    set done(x2) = ""
                }
            }
        }
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0
    set add = 1000000
    w "reading file",!
    set y = 1
    set maxx = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set maxx = len
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            set map(x,y) = c
        }
        if (line '[ "#") {
            w *9,"> expanding empty line",!
            set y = y + add - 1
        }
        set y = y + 1
    }
    set maxy = y

    w "Check empty cols",!
    for x=1:1:maxx {
        set fnd = 0 
        set y = 1
        while ((y<maxy) && (fnd = 0)) {
            if ($g(map(x,y)) = "#") { set fnd = 1 }
            set y = y + 1
        }
        if (fnd = 0) {
            set emptycols(x) = 1
        }
    }

    //zw map(1)
    set x = 1
    set ox = $ORDER(map(""))
    while (ox '= "") {
        w ox,!
        if $DATA(emptycols(ox)) { set x = x + add - 1}
        set y = $ORDER(map(ox,""))
        while y '="" {
            //if (ox = 1) { zw map(ox) }
            //if ((ox = 1)&&(y=3)){ w ox,*9,x,*9,y,*9,map(ox,y),!}
            set nmap(x,y) = map(ox,y)
            set y = $ORDER(map(ox,y))
        }
        set x = x + 1
        set ox = $ORDER(map(ox))
    }
    
    w "build galaxy list",!
    set x = $ORDER(nmap(""))
    while x '= "" {
        set y = $ORDER(nmap(x,""))
        while y '= "" {
            set c = nmap(x,y)
            if (c = "#") {
                set gal = $get(gal) + 1
                set gal(gal) = $LISTBUILD(x,y)
            }
            set y = $ORDER(nmap(x,y))
        }
        set x = $ORDER(nmap(x))
    }

    //do ..ShowMap(.nmap)
    /*zw nmap*/
    w "get distances",!
    for i=1:1:gal {
        for j=1:1:gal {
            if (i '= j) {
                set gi = gal(i)
                set gix = $LIST(gi,1)
                set giy = $LIST(gi,2) 
                set gj = gal(j)
                set gjx = $LIST(gj,1)
                set gjy = $LIST(gj,2)
                set x1 = gix_","_giy_"x"_gjx_"x"_gjy
                set x2 = gjx_","_gjy_"x"_gix_"x"_giy
                if ('$DATA(done(x1)) && '$DATA(done(x2))) {
                    set dist = $ZABS(gix - gjx) + $ZABS(giy - gjy)

                    //w i,"(",gix,"-",giy,")",*9,j,"(",gjx,"-",gjy,")",*9,dist,!

                    set result = result + dist
                    set done(x1) = ""
                    set done(x2) = ""
                }
            }
        }
    }

    zw nmap(1,3)
    zw map(1,3)

    Return result
}

ClassMethod ShowMap(map)
{
    set maxx = $order(map(""),-1)
    set maxy = $ORDER(map(maxx,""),-1)
    for y=1:1:maxy {
        for x=1:1:maxx {
            w $g(map(x,y),".")
        }
        w !
    }
    /*
    set x = $order(map(""))
    while (x '= "") {
        set y = $ORDER(map(x,""))
        while (y '= "") {
            set nmap(y,x) = $g(map(x,y),".")
            set y = $ORDER(map(x,y))
        }
        set x = $ORDER(map(x))
    }

    set y = $order(nmap(""))
    while (y '= "") {
        set x = $ORDER(nmap(y,""))
        while (x '= "") {
            w nmap(y,x)
            set x = $ORDER(nmap(y,x))
        }
        write !
        set y = $ORDER(nmap(y))
    }
    */
}

ClassMethod CorrectMap(map, newMap)
{
    kill newMap
    set nx = 1
    set x = $order(map(""))
    while (x '= "") {        
        set y = $order(map(x,""))
        while (y '= "") {
            set newMap(nx,y) = map(x,y)
            set y = $ORDER(map(x,y))
        }
        set nx = nx + 1
        set x = $ORDER(map(x))
    }
}

}
