Class AOC.Day10 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)

        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            Set map(x,y) = c
            If c = "S" {
                Set start = $LISTBUILD(x,y)
            }
        }

        Set y = y + 1
    }

    Set dx = 0
    Set dy = 0
    Set x = $LIST(start,1)
    Set y = $LIST(start,2)
    If ($DATA(map(x,y-1)) && ("F7|"[map(x,y-1))) { Set dy = -1 }
    ElseIf ($DATA(map(x,y+1)) && ("JL,|"[map(x,y+1))) { Set dy = 1 }
    ElseIf ($DATA(map(x-1,y)) && ("-LF"[map(x-1,y))) { Set dx = -1 }
    ElseIf ($DATA(map(x+1,y)) && ("-7J"[map(x-1,y))) { Set dx = 1 }

    Set cont = 1
    While cont {
        Set x = x + dx
        Set y = y + dy

        Set c = map(x,y)

        If ((c = "F") && ( dy = -1)) { 
            Set dy = 0 
            Set dx = 1
        }
        ElseIf ((c = "F") && (dy = 0)) {
            Set dy = 1
            Set dx = 0
        }
        ElseIf ((c = "7") && ( dy = -1)) { 
            Set dy = 0 
            Set dx = -1
        }
        ElseIf ((c = "7") && (dy = 0)) {
            Set dy = 1
            Set dx = 0
        }
        ElseIf ((c = "J") && ( dy = 1)) { 
            Set dy = 0 
            Set dx = -1
        }
        ElseIf ((c = "J") && (dy = 0)) {
            Set dy = -1
            Set dx = 0
        }
        ElseIf ((c = "L") && ( dy = 1)) { 
            Set dy = 0 
            Set dx = 1
        }
        ElseIf ((c = "L") && (dy = 0)) {
            Set dy = -1
            Set dx = 0
        }

        //Write x,*9,y,*9,dx,*9,dy,*9,c,*9,dx,*9,dy,!

        Set result = result + 1
        If (map(x,y) = "S") { Set cont = 0}
    }

    Return result/2
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..TestFile.AtEnd){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        Set boundx = len

        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            Set map(x,y) = c
            If c = "S" {
                Set start = $LISTBUILD(x,y)
            }
        }

        Set y = y + 1
    }

    Set boundy = y - 1

    Set dx = 0
    Set dy = 0
    Set x = $LIST(start,1)
    Set y = $LIST(start,2)
    If ($DATA(map(x,y-1)) && ("F7|"[map(x,y-1))) { Set dy = -1 }
    ElseIf ($DATA(map(x,y+1)) && ("JL,|"[map(x,y+1))) { Set dy = 1 }
    ElseIf ($DATA(map(x-1,y)) && ("-LF"[map(x-1,y))) { Set dx = -1 }
    ElseIf ($DATA(map(x+1,y)) && ("-7J"[map(x-1,y))) { Set dx = 1 }

    Set maxx = 0
    Set maxy = 0
    Set minx = 999999
    Set miny = 999999

    Set cont = 1
    While cont {
        Set x = x + dx
        Set y = y + dy
        If (x > maxx) { Set maxx = x }
        If (y > maxy) { Set maxy = y }
        If (x < minx) { Set minx = x }
        If (y < miny) { Set miny = y }

        Set c = map(x,y)

        If ((c = "F") && ( dy = -1)) { 
            Set dy = 0 
            Set dx = 1
        }
        ElseIf ((c = "F") && (dy = 0)) {
            Set dy = 1
            Set dx = 0
        }
        ElseIf ((c = "7") && ( dy = -1)) { 
            Set dy = 0 
            Set dx = -1
        }
        ElseIf ((c = "7") && (dy = 0)) {
            Set dy = 1
            Set dx = 0
        }
        ElseIf ((c = "J") && ( dy = 1)) { 
            Set dy = 0 
            Set dx = -1
        }
        ElseIf ((c = "J") && (dy = 0)) {
            Set dy = -1
            Set dx = 0
        }
        ElseIf ((c = "L") && ( dy = 1)) { 
            Set dy = 0 
            Set dx = 1
        }
        ElseIf ((c = "L") && (dy = 0)) {
            Set dy = -1
            Set dx = 0
        }

        //Write x,*9,y,*9,dx,*9,dy,*9,c,*9,dx,*9,dy,!
        Set pipe(x,y) = ""

        If (map(x,y) = "S") { Set cont = 0}
    }
    Do ..completeMap(boundx,boundy,.map)
    Do ..showmap(.map,boundx,boundy)
    /*
    For x=1:1:boundx {
        For y=1:1:boundy {
            //If ('$DATA(freepoints(x,y)) && '$DATA(trappedpoints(x,y))) {
                Kill visited
                Set free = ..isfree(x,y,boundx,boundy,"",.visited,.map)
                If free { Set freepoints(x,y) = map(x,y) }
                Else { Set trappedpoints(x,y) = map(x,y) }
            //}
        }
    }
    */
    Write !,..isfree(6,5,boundx,boundy,"|6x5|",.vis,.map),!,!
    //Write !,..isfree(4,4,boundx,boundy,"",.vis,.map),!
    //ZWrite vis
    
    Set x = $ORDER(trappedpoints(""))
    While (x '= "") {
        Set y =$ORDER(trappedpoints(x,""))
        While (y '= "") {
            If ("-|FL7SJ"'[map(x,y)) {
                Set result = result + 1
                Write map(x,y),!
            }
            Set y = $ORDER(trappedpoints(x,y))
        }
        Set x = $ORDER(trappedpoints(x))
    }
    ZWrite trappedpoints

    Return result
}

ClassMethod isfree2(x, y, boundx, boundy, from, visited, map)
{
    Set free = 0
    Set visited(x,y) = map(x,y)
    Write x,*9,y,*9,map(x,y),*9,from,!
    If (((x)<0) || ((x)>boundx) || ((y)<0) || ((y)>boundy)) {
        Set free = 1
    }
    Else {
        Set current = map(x,y)
        Set px = $PIECE($PIECE(from,"|",$LENGTH(from,"|")-1),"*",1)
        Set py = $PIECE($PIECE(from,"|",$LENGTH(from,"|")-1),"*",2)
        // up
        Set next = map(x,y-1)
        If (next '= "-") {
            Set free = ..isfree(x,y-1,boundx,boundy,from_"|"_x_"*"_y_"|",.visited,.map)
        }

    }
    Return free
}

ClassMethod isfree(x, y, boundx, boundy, from, visited, map)
{
    Set free = 0
    Set visited(x,y) = $GET(map(x,y),".")
    //Write x,*9,y,*9,$GET(map(x,y),"."),*9,from,!
    If (((x-0.5)<0) || ((x+0.5)>boundx) || ((y-0.5)<0) || ((y+0.5)>boundy)) {
        Set free = 1
    }
    Else {
        For dir="u","d","l","r" {
            If (dir  = "u") {
                Set ny = y+0.5
                Set nx = x
            } ElseIf (dir = "d") {
                Set ny = y-0.5
                Set nx = x
            } ElseIf (dir = "l") {
                Set ny = y
                Set nx = x-0.5
            } ElseIf (dir = "r") {
                Set ny = y
                Set nx = x+0.5
            }
            Set tst = "|"_nx_"x"_ny_"|"
            If (from '[ tst) {
                Set n = $GET(map(nx,ny),".")
                If (".IO"[n) {
                    Set free = ..isfree(nx,ny,boundx,boundy,from_"|"_nx_"x"_ny_"|",.visited,.map)
                }
            }
        }
    }
    Return free
}

ClassMethod completeMap(boundx, boundy, map)
{
     For x=1:1:boundx {
        For y=1:1:boundy {
            Set current = map(x,y)
            Set up = $GET(map(x,y-1),".")
            Set down = $GET(map(x,y+1),".")
            Set right = $GET(map(x+1,y),".")
            Set left = $GET(map(x-1,y),".")
            If (current = "-") {
                If ("-7J"[right) {Set map(x+0.5,y) = "-" }
                Else { Set map(x+0.5,y) = "." }
                If ("-FL"[left) {Set map(x-0.5,y) = "-" }
                Else { Set map(x-0.5,y) = "." }
                Set map(x,y+0.5)="."
                Set map(x,y-0.5)="."
            }
            ElseIf (current = "|") {
                If ("|7F"[up) {Set map(x,y-0.5) = "|" }
                Else { Set map(x,y-0.5) = "." }
                If ("|JL"[down) {Set map(x,y+0.5) = "|" }
                Else { Set map(x,y+0.5) = "." }
                Set map(x+0.5,y)="."
                Set map(x-0.5,y)="."
            }
            ElseIf (current = "7") {
                If ("|JL"[down) {Set map(x,y+0.5) = "|" }
                Else { Set map(x,y+0.5) = "." }
                If ("-FL"[left) {Set map(x-0.5,y) = "-" }
                Else { Set map(x-0.5,y) = "." }
                Set map(x+0.5,y)="."
                Set map(x,y-0.5)="."
            }
            ElseIf (current = "L") {
                If ("|F7"[up) {Set map(x,y-0.5) = "|" }
                Else { Set map(x,y-0.5) = "." }
                If ("-7J"[right) {Set map(x+0.5,y) = "-" }
                Else { Set map(x+0.5,y) = "." }                
                Set map(x-0.5,y)="."
                Set map(x,y+0.5)="."
            }
            ElseIf (current = "J") {
                If ("|F7"[up) {Set map(x,y-0.5) = "|" }
                Else { Set map(x,y-0.5) = "." }
                If ("-FL"[left) {Set map(x-0.5,y) = "-" }
                Else { Set map(x-0.5,y) = "." }
                Set map(x+0.5,y)="."
                Set map(x,y+0.5)="."
            }
            ElseIf (current = "F") {
                If ("|JL"[down) {Set map(x,y+0.5) = "|" }
                Else { Set map(x,y+0.5) = "." }
                If ("-7J"[right) {Set map(x+0.5,y) = "-" }
                Else { Set map(x+0.5,y) = "." }
                Set map(x-0.5,y)="."
                Set map(x,y+0.5)="."
            }
            Else {
                Set map(x,y+0.5)="."
                Set map(x,y-0.5)="."
                Set map(x+0.5,y)="."
                Set map(x-0.5,y)="."
            }
        }
    }
}

ClassMethod showmap(map, boundx, boundy)
{
    Set x = $ORDER(map(""))
    While x'="" {
        Set y = $ORDER(map(x,""))
        While y'="" {
            Set nmap(y,x)=map(x,y)
            Set y = $ORDER(map(x,y))
        }
        Set x = $ORDER(map(x))
    }
    For y=1:0.5:boundy {
        For x=1:0.5:boundx {
            Write $GET(nmap(y,x),".")
        }
        Write !
    }
}

ClassMethod isfreeOLD(x, y, boundx, boundy, from, visited, map)
{
    Set free = 0
    Set visited(x,y) = map(x,y)
    Write x,*9,y,*9,map(x,y),*9,from,!
    If (((x-1)<0) || ((x+1)>boundx) || ((y-1)<0) || ((y+1)>boundy)) {
        Set free = 1
    }
    Else {
        If ($DATA(map(x,y-1))) {
            If ((map(x,y) '= "-") && ("-"'[map(x,y-1))  && ('$DATA(visited(x,y-1)))) {
                Set stop = 0
                If ("|FL7J" [ map(x,y) ) {
                    If ((from [ "L") && (map(x,y-1) = "7")) {Set stop = 1 }
                    If ((from [ "R") && (map(x,y-1) = "F")) {Set stop = 1 }
                    //If ((from [ "B") && ("F7" [ map(x,y-1))) {Set stop = 1 }
                }
                If (stop = 0) {
                    Set n = map(x,y-1)
                    If (n = "L") { Set from = "LB"_$TRANSLATE(from,"LBTR") } 
                    ElseIf (n = "J") { Set from = "RB"_$TRANSLATE(from,"LBTR")}
                    Set free = ..isfree(x,y-1,boundx,boundy,from_"|"_x_"*"_y_"|",.visited,.map)
                }
            }
        }
        If ('free && $DATA(map(x,y+1))) {
            If ((map(x,y) '= "-") && ("-"'[map(x,y+1)) && '$DATA(visitedx(y+1))) {
                Set stop = 0
                If ("|FL7J" [ map(x,y)) {
                    If ((from [ "R") && (map(x,y+1) = "L")) {Set stop = 1 }
                    If ((from [ "L") && (map(x,y+1) = "J")) {Set stop = 1 }
                    //If ((from [ "T") && ("LJ" [ map(x,y+1))) {Set stop = 1 }
                }
                If (stop = 0) {
                    Set n = map(x,y+1)
                    If (n = "F") { Set from = "LT"_$TRANSLATE(from,"LBTR") } 
                    ElseIf (n = "7") { Set from = "RT"_$TRANSLATE(from,"LBTR")}
                    Set free = ..isfree(x,y+1,boundx,boundy,from_"|"_x_"*"_y_"|",.visited,.map)
                }
            }
        }
        If ('free && $DATA(map(x-1,y))) {
            If ((map(x,y) '= "|") && ("|"'[map(x-1,y)) && '$DATA(visited(x-1,y))) {
                Set stop = 0
                If ("-FL7J" [ map(x,y)) {
                    If ((from [ "B") && (map(x-1,y) = "F")) {Set stop = 1 }
                    If ((from [ "T") && (map(x-1,y) = "L")) {Set stop = 1 }
                    //If ((from [ "R") && ("FL" [ map(x-1,y))) {Set stop = 1 }
                }
                If (stop = 0) {
                    Set n = map(x-1,y)
                    If (n = "7") { Set from = "RT"_$TRANSLATE(from,"LBTR") } 
                    ElseIf (n = "J") { Set from = "RB"_$TRANSLATE(from,"LBTR")}
                    Set free = ..isfree(x-1,y,boundx,boundy,from_"|"_x_"*"_y_"|",.visited,.map)
                }
            }
        }
        If ('free && $DATA(map(x+1,y))) {
            If ((map(x,y) '= "|") && ("|"'[map(x+1,y)) && '$DATA(visited(x+1,y))) {
                Set stop = 0
                If ("-FL7J" [ map(x,y)) {
                    If ((from [ "B") && (map(x+1,y) = "7")) {Set stop = 1 }
                    If ((from [ "T") && (map(x+1,y) = "J")) {Set stop = 1 }
                    //If ((from [ "L") && ("7J" [ map(x+1,y))) {Set stop = 1 }
                }
                If (stop = 0) {
                    Set n = map(x+1,y)
                    If (n = "F") { Set from = "LT"_$TRANSLATE(from,"LBTR") } 
                    ElseIf (n = "L") { Set from = "LB"_$TRANSLATE(from,"LBTR") }
                    Set free = ..isfree(x+1,y,boundx,boundy,from_"|"_x_"*"_y_"|",.visited,.map)
                }
            }
        }
    }
    Return free
}

}
