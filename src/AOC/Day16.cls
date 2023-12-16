Class AOC.Day16 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set maxx = 0
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len > maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            Set map(x,y) = c
        }
        Set y = y + 1
    }
    Set maxy = y - 1
    
    Do ..Show(.map,.visited)
    Write !,!

    Do ..Step(1,1,"D",maxx,maxy,.map,.visited)

    Do ..Show(.map,.visited)
    //ZWrite visited
    Set x = $ORDER(visited("")) 
    While (x '= "") {
        Set y = $ORDER(visited(x,""))
        While (y '= "") {
            Set result = result + 1
            Set y = $ORDER(visited(x,y))
        }
        Set x = $ORDER(visited(x))
    }

    Return result
}

ClassMethod Show(map, visited)
{
    Set x = $ORDER(map("")) 
    While (x '= "") {
        Set y = $ORDER(map(x,""))
        While (y '= "") {
            If ('$DATA(visited(x,y))) {
                Set xmap(y,x) = map(x,y)
            }
            Else { Set xmap(y,x) = "#"}
            Set y = $ORDER(map(x,y))
        }
        Set x = $ORDER(map(x))
    }
    Set y = $ORDER(xmap("")) 
    While (y '= "") {
        Set x = $ORDER(xmap(y,""))
        While (x '= "") {
            Write xmap(y,x)
            Set x = $ORDER(map(y,x))
        }
        Write !
        Set y = $ORDER(xmap(y))
    }
}

ClassMethod Step(cx, cy, dir, maxx, maxy, map, visited)
{
    While ((cx <= maxx) && (cy <= maxy) && (cx > 0) && (cy > 0) && ($GET(visited(cx,cy)) '[ dir)) {
       //Write cx,*9,cy,*9,dir,!
        Set dx = 0
        Set dy = 0
        If (dir = "D") { Set dy = 1 }
        ElseIf (dir = "U") { Set dy = -1 }
        ElseIf (dir = "R") { Set dx = 1 }
        ElseIf (dir = "L") { Set dx = -1 }
        Set visited(cx,cy) = $GET(visited(cx,cy))_dir
        If $DATA(map(cx+dx,cy+dy)) {
            Set nc = map(cx+dx,cy+dy)
            
            If (nc = ".") {
                Set cx = cx + dx
                Set cy = cy + dy
            }
            ElseIf (nc = "/") {
                If (dir = "R") { Set dir ="U" }
                ElseIf (dir = "L") { Set dir = "D" }
                ElseIf (dir = "U") { Set dir = "R" }
                ElseIf (dir = "D") { Set dir = "L" }
                Set cx = cx + dx
                Set cy = cy + dy
            }
            ElseIf (nc = "\") {
                If (dir = "R") { Set dir ="D" }
                ElseIf (dir = "L") { Set dir = "U" }
                ElseIf (dir = "U") { Set dir = "L" }
                ElseIf (dir = "D") { Set dir = "R" }
                Set cx = cx + dx
                Set cy = cy + dy
            }
            ElseIf (nc = "|") {            
                If (dir = "U") { 
                    Set cx = cx + dx
                    Set cy = cy + dy
                 }
                ElseIf (dir = "D") { 
                    Set cx = cx + dx
                    Set cy = cy + dy
                }
                Else { 
                    Do ..Step(cx+dx,cy+dy,"D",maxx,maxy,.map,.visited) 
                    Do ..Step(cx+dx,cy+dy,"U",maxx,maxy,.map,.visited) 
                }
            }   
            ElseIf (nc = "-") {
                If (dir = "L") { 
                    Set cx = cx + dx
                    Set cy = cy + dy
                }
                ElseIf (dir = "R") { 
                    Set cx = cx + dx
                    Set cy = cy + dy
                }
                Else { 
                    Do ..Step(cx+dx,cy+dy,"R",maxx,maxy,.map,.visited) 
                    Do ..Step(cx+dx,cy+dy,"L",maxx,maxy,.map,.visited) 
                }
            }
        }
    }
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set maxx = 0
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len > maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            Set map(x,y) = c
        }
        Set y = y + 1
    }
    Set maxy = y - 1
    
    //Do ..Show(.map,.visited)
    //Write !,!
    For tx=1:1:maxx {
        For ty=1,maxy{
            If ty = 1 { Set dir = "D"}
            Else {Set dir = "U" }
            Kill visited
            Set tile = map(tx,ty)
            If ((tile) = "/") {
                If (dir = "R") { Set dir = "U" }
                ElseIf (dir = "L") {Set dir = "D" }
                ElseIf (dir = "U") {Set dir = "R" }
                ElseIf (dir = "D") {Set dir = "L" }
            }
            ElseIf ((tile) = "\") {
                If (dir = "R") { Set dir = "D" }
                ElseIf (dir = "L") {Set dir = "U" }
                ElseIf (dir = "U") {Set dir = "L" }
                ElseIf (dir = "D") {Set dir = "R" }
            }
            If (tile '= "|") && (tile '= "-") {
                Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
            } Else {
                If (tile = "|") {
                    If ("UD" [ dir){
                        Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
                    }
                    Else {
                        Do ..Step(tx,ty,"U",maxx,maxy,.map,.visited)                
                        Do ..Step(tx,ty,"D",maxx,maxy,.map,.visited)
                    }
                }
                If (tile = "-") {
                    If ("LR" [ dir){
                        Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
                    }
                    Else {
                        Do ..Step(tx,ty,"L",maxx,maxy,.map,.visited)                
                        Do ..Step(tx,ty,"R",maxx,maxy,.map,.visited)
                    }
                }
            }

            //Do ..Show(.map,.visited)
            //ZWrite visited
            Set temp = 0
            Set x = $ORDER(visited("")) 
            While (x '= "") {
                Set y = $ORDER(visited(x,""))
                While (y '= "") {
                    Set temp = temp + 1
                    Set y = $ORDER(visited(x,y))
                }
                Set x = $ORDER(visited(x))
            }
            //Write tx,*9,ty,*9,dir,*9,temp,!
            If (temp > result) { Set result = temp }
        }
    }

    For ty=1:1:maxy {
        For tx=1,maxx{
            If ty = 1 { Set dir = "R"}
            Else {Set dir = "L" }
            Kill visited
            Set tile = map(tx,ty)
            If ((tile) = "/") {
                If (dir = "R") { Set dir = "U" }
                ElseIf (dir = "L") {Set dir = "D" }
                ElseIf (dir = "U") {Set dir = "R" }
                ElseIf (dir = "D") {Set dir = "L" }
            }
            ElseIf ((tile) = "\") {
                If (dir = "R") { Set dir = "D" }
                ElseIf (dir = "L") {Set dir = "U" }
                ElseIf (dir = "U") {Set dir = "L" }
                ElseIf (dir = "D") {Set dir = "R" }
            }
            If (tile '= "|") && (tile '= "-") {
                Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
            } Else {
                If (tile = "|") {
                    If ("UD" [ dir){
                        Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
                    }
                    Else {
                        Do ..Step(tx,ty,"U",maxx,maxy,.map,.visited)                
                        Do ..Step(tx,ty,"D",maxx,maxy,.map,.visited)
                    }
                }
                If (tile = "-") {
                    If ("LR" [ dir){
                        Do ..Step(tx,ty,dir,maxx,maxy,.map,.visited)
                    }
                    Else {
                        Do ..Step(tx,ty,"L",maxx,maxy,.map,.visited)                
                        Do ..Step(tx,ty,"R",maxx,maxy,.map,.visited)
                    }
                }
            }

            //Do ..Show(.map,.visited)
            //ZWrite visited
            Set temp = 0
            Set x = $ORDER(visited("")) 
            While (x '= "") {
                Set y = $ORDER(visited(x,""))
                While (y '= "") {
                    Set temp = temp + 1
                    Set y = $ORDER(visited(x,y))
                }
                Set x = $ORDER(visited(x))
            }
            //Write tx,*9,ty,*9,dir,*9,temp,!
            If (temp > result) { Set result = temp }
        }
    }

    Return result
}

}
