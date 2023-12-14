Class AOC.Day14 Extends AOC.Base
{

Method Part1() As %String
{
    Set result = 0 
    set maxx = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len>maxx) { set maxx = len }
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            //set map(y,x) = c

            set ty = y
            if (c = "O") {
                set stop = 0
                while ((ty > 1) && (stop = 0)) {
                    if ($get(map(ty-1,x),".") '= "." ) { set stop = 1 }
                    if (stop = 0 ) { set ty = ty - 1 }
                }
            }
            set map(ty,x) = c

        }
        set y = y + 1
    }
    
    set maxy = y - 1
    for y=1:1:maxy {
        for x=1:1:maxx {
            if $get(map(y,x),".") = "O" {
                set add = (maxy - (y-1))
                //write add,!
                set result = result + add
            }
            //write $get(map(y,x),".")
        }
        //write !
    }

    return result
}

Method Part2(cycles = 1000000000) As %String
{
    Set result = 0 
    set maxx = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        if (len>maxx) { set maxx = len }
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            
            set map(y,x) = c

        }
        set y = y + 1
    }

    set maxy = y - 1

    //d ..ShowMap(maxx,maxy,.map)

    for i=1:1:cycles {
        for dir = "N","W","S","E" {
            kill nmap
            if (dir = "N")
            {
                for y=1:1:maxy {
                    for x=1:1:maxx {
                        set c = $GET(map(y,x),".")

                        set ty = y
                        if (c = "O") {
                            set stop = 0
                            while ((ty > 1) && (stop = 0)) {
                                if ($get(nmap(ty-1,x),".") '= "." ) { set stop = 1 }
                                if (stop = 0 ) { set ty = ty - 1 }
                            }
                        }
                        set nmap(ty,x) = c

                    }
                }
                kill map
                merge map = nmap
            }
            if (dir = "E") {
                for x=maxx:-1:1 {
                    for y=1:1:maxy {
                        set c = $GET(map(y,x),".")

                        set tx = x
                        if (c = "O") {
                            set stop = 0
                            while ((tx < maxx) && (stop = 0)) {
                                if ($get(nmap(y,tx+1),".") '= "." ) { set stop = 1 }
                                if (stop = 0 ) { set tx = tx + 1 }
                            }
                        }
                        set nmap(y,tx) = c
                    }
                }
                kill map
                merge map = nmap
            }
            if (dir = "S")
            {
                for y=maxy:-1:1 {
                    for x=1:1:maxx {
                        set c = $GET(map(y,x),".")

                        set ty = y
                        if (c = "O") {
                            set stop = 0
                            while ((ty < maxy) && (stop = 0)) {
                                if ($get(nmap(ty+1,x),".") '= "." ) { set stop = 1 }
                                if (stop = 0 ) { set ty = ty + 1 }
                            }
                        }
                        set nmap(ty,x) = c

                    }
                }
                kill map
                merge map = nmap
            }
            if (dir = "W") {
                for x=1:1:maxx {
                    for y=1:1:maxy {
                        set c = $GET(map(y,x),".")

                        set tx = x
                        if (c = "O") {
                            set stop = 0
                            while ((tx > 1) && (stop = 0)) {
                                if ($get(nmap(y,tx-1),".") '= "." ) { set stop = 1 }
                                if (stop = 0 ) { set tx = tx - 1 }
                            }
                        }
                        set nmap(y,tx) = c
                    }
                }
                kill map
                merge map = nmap
            }
            //do ..ShowMap(maxx,maxy,.map)
        }
    }
    
    for y=1:1:maxy {
        for x=1:1:maxx {
            if $get(map(y,x),".") = "O" {
                set add = (maxy - (y-1))
                set result = result + add
            }            
            //write $get(map(y,x),".")
        }
        //write !
    }

    return result
}

ClassMethod ShowMap(maxx, maxy, map)
{
    for y=1:1:maxy {
        for x=1:1:maxx {
            write $get(map(y,x),".")
        }
        write !
    }
    write !
}

}
