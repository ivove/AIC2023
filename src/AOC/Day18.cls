Class AOC.Day18 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    Set x = 1
    Set y = 1
    Set maxx = 0
    Set maxy = 0
    Set miny = 999999
    Set minx = 999999
    Set trench(x,y) = "#"

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set dir = $PIECE(line," ",1)
        Set len = $PIECE(line," " ,2)

        Set dx = 0
        Set dy = 0
        If (dir = "U") { Set dy = -1 }
        ElseIf (dir = "D") { Set dy = 1 }
        ElseIf (dir = "R") { Set dx = 1 }
        ElseIf (dir = "L") { Set dx = -1 }

        For i=1:1:len {
            Set x = x + dx
            Set y = y + dy
            Set trench(x,y) = "#"
            Set itrench(y,x) = "#"
        }

        If (x > maxx) { Set maxx = x }
        If (y > maxy) { Set maxy = y }
        If (y < miny) { Set miny = y }
        If (x < minx) { Set minx = x }

    }

    Do ..Show(minx,miny,maxx,maxy,.trench)
    
    Set xx = $ORDER(itrench(miny,""))
    Write minx,*9,xx,!

    Do ..Dig(xx+1,miny+1,.trench)

    Write !,!
    Hang 1
    Do ..Show(minx,miny,maxx,maxy,.trench)

    For x=minx:1:maxx {
        For y=miny:1:maxy {
            If ($GET(trench(x,y),".") = "#" ) {
                Set result = result + 1
            }
        }
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 
    Set x = 1
    Set y = 1
    Set maxx = 0
    Set maxy = 0
    Set miny = 999999
    Set minx = 999999
    Set ^||trench(x,y) = "#"

    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        
        Set len = $EXTRACT($PIECE(line," " ,3),3,*-1)
        Set dir = $EXTRACT(len,*)
        Set len = $SYSTEM.Util.HexToDecimal($EXTRACT(len,1,*-1))
        
        Set dx = 0
        Set dy = 0
        If (dir = "3") { Set dy = -1 }
        ElseIf (dir = "1") { Set dy = 1 }
        ElseIf (dir = "0") { Set dx = 1 }
        ElseIf (dir = "2") { Set dx = -1 }

        For i=1:1:len {
            Set x = x + dx
            Set y = y + dy
            Set ^||trench(x,y) = "#"
            Set itrench(y,x) = "#"
        }

        If (x > maxx) { Set maxx = x }
        If (y > maxy) { Set maxy = y }
        If (y < miny) { Set miny = y }
        If (x < minx) { Set minx = x }

    }
    Write minx,*9,maxx,*9,miny,*9,maxy,!
    //Do ..Show(minx,miny,maxx,maxy,.trench)
    
    Set xx = $ORDER(itrench(miny,""))
    Write minx,*9,xx,!

    Do ..Dig(xx+1,miny+1,.trench)

    //Write !,!
    //Hang 1
    //Do ..Show(minx,miny,maxx,maxy,.trench)

    For x=minx:1:maxx {
        For y=miny:1:maxy {
            If ($GET(^||trench(x,y),".") = "#" ) {
                Set result = result + 1
            }
        }
    }

    Return result
}

ClassMethod Dig(x, y, map)
{
    Set ^||edge(x,y) = ""
    While $DATA(^||edge) {
    Set tx = $ORDER(^||edge(""))
    While tx '= "" {
        Set ty = $ORDER(^||edge(tx,""))
        While ty '= "" {
            Kill ^||edge(tx,ty)
            Set map(tx,ty) = "#"
            Set visited(tx,ty) = ""
            For dx=-1:1:1{
                For dy=-1:1:1 {
                    If $GET(map(tx+dx,ty+dy)) '= "#" {
                        Set ^||edge(tx+dx,ty+dy) = ""
                    }
                }
            }
            Set ty = $ORDER(^||edge(tx,ty))
        }
        Set tx = $ORDER(^||edge(tx))
    }
    }
}

ClassMethod Dig2(x, y)
{
    Set edge(x,y) = ""
    While $DATA(edge) {
    Set tx = $ORDER(edge(""))
    While tx '= "" {
        Set ty = $ORDER(edge(tx,""))
        While ty '= "" {
            Kill edge(tx,ty)
            Set ^||trench(tx,ty) = "#"
            Set visited(tx,ty) = ""
            For dx=-1:1:1{
                For dy=-1:1:1 {
                    If $GET(^||trench(tx+dx,ty+dy)) '= "#" {
                        Set edge(tx+dx,ty+dy) = ""
                    }
                }
            }
            Set ty = $ORDER(edge(tx,ty))
        }
        Set tx = $ORDER(edge(tx))
    }
    }
}

ClassMethod Show(minx, miny, maxx, maxy, trench)
{
    Set file=##class(%File).%New("c:\AOC2023\out\day18"_$HOROLOG_".txt")
    Do file.Open("WSN")
    Do file.WriteLine("This is a line of text")
    For y=miny:1:maxy {
        Set line = ""
        For x=minx:1:maxx {
            If $GET(trench(x,y))'="" {
                Set line = line_$GET(trench(x,y),".")
            } Else {
                Set line = line_"."
            }
        }
        Do file.WriteLine(line)
    }
    Do file.Close()
}

ClassMethod IsFree(x, y, boundx, boundy, map, visited)
{
    Kill visited
    Kill edge
    Set free = 0
    Set done = 0
    Set edge(x,y) = ""
    While ((free = 0) && (done = 0)) {
        Set x = $ORDER(edge(""))
        While (x '= "") {
            Set y = $ORDER(edge(x,""))
            While (y '= "") {
                For dx=-1:1:1 {
                    For dy=-1:1:1 {
                        Set nx = x+dx
                        Set ny = y+dy
                        If (((nx)<1) || ((nx)>boundx) || ((ny)<1) || ((ny)>boundy)) {
                            Set free = 1
                        }
                        Else {
                            If ('$DATA(visited(nx,ny))) {
                                Set n = $GET(map(nx,ny),".")
                                If ((n = ".") && (free = 0)) {
                                    Set visited(x,y)=$GET(map(x,y),".")
                                    Set edge(nx,ny)=""
                                }
                            }
                        }
                    }
                }
                Set visited(x,y) = $GET(map(x,y),".")
                Kill edge(x,y)
                Set y = $ORDER(edge(x,y))
            }
            Set x = $ORDER(edge(x))
        }
        If ('$DATA(edge)) { Set done = 1 }
    }
    //write boundx,*9,boundy,!
    //zw visited
    Return free
}

}
