Class AOC.Day14 Extends AOC.Base
{

Method Part1() As %String
{
    Set result = 0 
    Set maxx = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len>maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            //set map(y,x) = c

            Set ty = y
            If (c = "O") {
                Set stop = 0
                While ((ty > 1) && (stop = 0)) {
                    If ($GET(map(ty-1,x),".") '= "." ) { Set stop = 1 }
                    If (stop = 0 ) { Set ty = ty - 1 }
                }
            }
            Set map(ty,x) = c

        }
        Set y = y + 1
    }
    
    Set maxy = y - 1
    For y=1:1:maxy {
        For x=1:1:maxx {
            If $GET(map(y,x),".") = "O" {
                Set add = (maxy - (y-1))
                //write add,!
                Set result = result + add
            }
            //write $get(map(y,x),".")
        }
        //write !
    }

    Return result
}

Method Part2(cycles = 1000000000) As %String
{
    Set result = 0 
    Set maxx = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len>maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            
            Set map(y,x) = c

        }
        Set y = y + 1
    }

    Set maxy = y - 1

    //d ..ShowMap(maxx,maxy,.map)

    For i=1:1:cycles {
        For dir = "N","W","S","E" {
            Kill nmap
            If (dir = "N")
            {
                For y=1:1:maxy {
                    For x=1:1:maxx {
                        Set c = $GET(map(y,x),".")

                        Set ty = y
                        If (c = "O") {
                            Set stop = 0
                            While ((ty > 1) && (stop = 0)) {
                                If ($GET(nmap(ty-1,x),".") '= "." ) { Set stop = 1 }
                                If (stop = 0 ) { Set ty = ty - 1 }
                            }
                        }
                        Set nmap(ty,x) = c

                    }
                }
                Kill map
                Merge map = nmap
            }
            If (dir = "E") {
                For x=maxx:-1:1 {
                    For y=1:1:maxy {
                        Set c = $GET(map(y,x),".")

                        Set tx = x
                        If (c = "O") {
                            Set stop = 0
                            While ((tx < maxx) && (stop = 0)) {
                                If ($GET(nmap(y,tx+1),".") '= "." ) { Set stop = 1 }
                                If (stop = 0 ) { Set tx = tx + 1 }
                            }
                        }
                        Set nmap(y,tx) = c
                    }
                }
                Kill map
                Merge map = nmap
            }
            If (dir = "S")
            {
                For y=maxy:-1:1 {
                    For x=1:1:maxx {
                        Set c = $GET(map(y,x),".")

                        Set ty = y
                        If (c = "O") {
                            Set stop = 0
                            While ((ty < maxy) && (stop = 0)) {
                                If ($GET(nmap(ty+1,x),".") '= "." ) { Set stop = 1 }
                                If (stop = 0 ) { Set ty = ty + 1 }
                            }
                        }
                        Set nmap(ty,x) = c

                    }
                }
                Kill map
                Merge map = nmap
            }
            If (dir = "W") {
                For x=1:1:maxx {
                    For y=1:1:maxy {
                        Set c = $GET(map(y,x),".")

                        Set tx = x
                        If (c = "O") {
                            Set stop = 0
                            While ((tx > 1) && (stop = 0)) {
                                If ($GET(nmap(y,tx-1),".") '= "." ) { Set stop = 1 }
                                If (stop = 0 ) { Set tx = tx - 1 }
                            }
                        }
                        Set nmap(y,tx) = c
                    }
                }
                Kill map
                Merge map = nmap
            }
            //do ..ShowMap(maxx,maxy,.map)
        }
    }
    
    For y=1:1:maxy {
        For x=1:1:maxx {
            If $GET(map(y,x),".") = "O" {
                Set add = (maxy - (y-1))
                Set result = result + add
            }            
            //write $get(map(y,x),".")
        }
        //write !
    }

    Return result
}

ClassMethod ShowMap(maxx, maxy, map)
{
    For y=1:1:maxy {
        For x=1:1:maxx {
            Write $GET(map(y,x),".")
        }
        Write !
    }
    Write !
}

Method Part2b(cycles = 1000000000) As %String
{
    Set result = 0 
    Set maxx = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len>maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            
            If (c = "#") {
                Set rock(x,y) = ""
                Set irock(y,x) = ""
            }

            If (c = "O") {
                Set ball(x,y) = ""
                Set iball(y,x) = ""
            }
            Set map(y,x) = c

        }
        Set y = y + 1
    }
    
    Set maxy = y - 1

    For i=1:1:cycles {
        For dir = "N","W","S","E" {
            Kill nball,niball
            If (dir = "N") {
                Set x = $ORDER(ball(""))
                While x '= "" {
                    Set y = $ORDER(ball(x,""))
                    While y '= "" {
                        Set ny = $ORDER(irock(y),-1) + 1
                        Set ny2 = $ORDER(niball(y),-1) + 1
                        If ny < ny2 { Set ny = ny2 }
                        Set nball(x,ny) = ""
                        Set niball(ny,x) = ""
                        Set y = $ORDER(ball(x,y))
                    }
                    Set x = $ORDER(ball(x))
                }
            }
            If (dir = "S") {
                Set x = $ORDER(ball(""))
                While x '= "" {
                    Set y = $ORDER(ball(x,""))
                    While y '= "" {
                        Set ny = $ORDER(irock(y)) - 1
                        Set ny2 = $ORDER(niball(y)) - 1
                        If ny > ny2 { Set ny = ny2 }
                        Set nball(x,ny) = ""
                        Set niball(ny,x) = ""
                        Set y = $ORDER(ball(x,y))
                    }
                    Set x = $ORDER(ball(x))
                }
            }
            If (dir = "E") {
                Set x = $ORDER(ball(""))
                While x '= "" {
                    Set y = $ORDER(ball(x,""))
                    While y '= "" {
                        Set nx = $ORDER(rock(x),-1) + 1
                        Set nx2 = $ORDER(nball(x),-1) + 1
                        If nx < nx2 { Set nx = nx2 }
                        Set nball(nx,y) = ""
                        Set niball(y,nx) = ""
                        Set y = $ORDER(ball(x,y))
                    }
                    Set x = $ORDER(ball(x))
                }
            }
            If (dir = "W") {
                Set x = $ORDER(ball(""))
                While x '= "" {
                    Set y = $ORDER(ball(x,""))
                    While y '= "" {
                        Set nx = $ORDER(rock(x)) - 1
                        Set nx2 = $ORDER(nball(x)) - 1
                        If nx > nx2 { Set nx = nx2 }
                        Set nball(nx,y) = ""
                        Set niball(y,nx) = ""
                        Set y = $ORDER(ball(x,y))
                    }
                    Set x = $ORDER(ball(x))
                }
            }
            Kill ball,iball
            Merge ball = nball
            Merge iball = niball
        }

    }

    Set y =$ORDER(iball(""))
    While y '= "" {
        Set x = $ORDER(iball(y,""))
        While x '= "" {
            Set add = (maxy - (y-1))
            Set result = result + add
            Set x = $ORDER(iball(y,x))
        }
        Set y = $ORDER(iball(y))
    }
    
    Return result
}

}
