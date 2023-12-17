Class AOC.Day17 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set maxx = 0
    Set y = 1
    While ('..TestFile.AtEnd){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        Set len = $LENGTH(line)
        If (len > maxx) { Set maxx = len }
        For x=1:1:len {
            Set c = $EXTRACT(line,x)
            Set map(y,x) = c
        }
        Set y = y + 1
    }
    Set maxy = y - 1
    Set ^||minscore = 999999999999
    //Do ..Step(1,1,maxx,maxy,.map,"",2,"",.paths,.visited)
    For dir=$LISTBUILD(1,0),$LISTBUILD(-1,0),$LISTBUILD(0,1),$LISTBUILD(0,-1)
    {    
        ZWrite dir
        Do ..Go(1,1,maxx,maxy,dir,"","",.map,"",.paths,"",0)
    }
    ZWrite paths
    Set result = $ORDER(paths(""))
    Set result = result - $EXTRACT(paths(result),1)

    Return result
}

ClassMethod Go(x, y, maxx, maxy, dir, pdir, ppdir, map, path, paths, visisted, currscore)
{
    Set path = $GET(path)_map(y,x)
    Set currscore = currscore + map(y,x)
    If currscore < ^||minscore {
        Set visisted = visisted_"|"_x_"*"_y_"|"
        If ((x = maxx) && (y = maxy)){
            Set paths(currscore) = path
            Set ^||minscore = currscore
        }
        Else {
            Set nx = x + $LIST(dir,1)
            Set ny = y + $LIST(dir,2)

            Set oppdir = $LISTBUILD($LIST(dir,1)*-1,$LIST(dir,2)*-1)
            
            If visisted '[ ("|"_nx_"*"_ny_"|") {
                If $DATA(map(ny+1,nx)) { Set pos(map(ny+1,nx),(ny+1)_","_nx) = $LISTBUILD(0,1) }
                If $DATA(map(ny-1,nx)) { Set pos(map(ny-1,nx),(ny-1)_","_nx) = $LISTBUILD(0,-1) }
                If $DATA(map(ny,nx+1)) { Set pos(map(ny,nx+1),ny_","_(nx+1)) = $LISTBUILD(1,0) }
                If $DATA(map(ny,nx-1)) { Set pos(map(ny,nx-1),ny_","_(nx-1)) = $LISTBUILD(-1,0) }
                /*Write nx,*9,ny,!
                ZWrite pos
                Write "**************************************************************",!*/
                Set cost = $ORDER(pos(""))
                While cost '= "" {
                    Set xx = $ORDER(pos(cost,""))
                    While xx '= "" {
                        If (pos(cost,xx) '= oppdir) {
                            If ((dir = pdir) && (pdir = ppdir) && (pos(cost,xx) = dir)) {}
                            Else {
                                Do ..Go(nx,ny,maxx,maxy,pos(cost,xx),dir,pdir,.map,path,.paths,visisted,currscore)
                            }
                        }
                        Set xx = $ORDER(pos(cost,xx))
                    }
                    Set cost = $ORDER(pos(cost))
                }
            }

        }
    }
}

ClassMethod A(map, maxx, maxy)
{
    Set open(map(1,1),1_","_1) = ""
    Set stop = 0
    Set s = $ORDER(open(""))
    While (s '= "") && (stop = 0) {
        Set current = $ORDER(open(s,""))
        While (current '= "") && (stop = 0) {
            
            Set current = $ORDER(open(s,current))
        }
        Set s = $ORDER(open(s))
    }
}

ClassMethod Step(x, y, maxx, maxy, map, dir, atl, path, paths, visited)
{
    //Write x,*9,y,*9,visited,!
    //If ..CalculateSocre(path) < ^||minscore {
        If ((x > 0) && (y > 0) && (x <= maxx) && (y <= maxy)) {
            Set path = path_map(y,x)
            Set visited(x,y) =$GET(visited(x,y))_dir
            If ((x = maxx) && (y = maxy)) {
                Set score = ..CalculateSocre(path)
                Write score,!,path
                Set paths(score) = path
                Set ^||minscore = score
            }
            Else {
                Set dirs = "RDUL"
                If atl = 3 {
                    Set dirs = $TRANSLATE(dirs,dir,"")
                }
                If (dir = "U") { Set dirs = $TRANSLATE(dirs,"D","") }
                ElseIf (dir = "D") { Set dirs = $TRANSLATE(dirs,"U","") }
                ElseIf (dir = "R") { Set dirs = $TRANSLATE(dirs,"L","") }
                ElseIf (dir = "L") { Set dirs = $TRANSLATE(dirs,"R","") }
                
                //Write *9,dir,*9,atl,*9,dirs,!

                Set len = $LENGTH(dirs)
                For i=1:1:len {
                    Set ndir = $EXTRACT(dirs,i)
                    //Write *9,ndir,!
                    Set dx = 0
                    Set dy = 0
                    If (ndir = "U") { Set dy = -1 }
                    ElseIf (ndir = "D") { Set dy = 1 }
                    ElseIf (ndir = "L") { Set dx = -1 }                
                    ElseIf (ndir = "R") { Set dx = 1 }

                    Set nx = x + dx
                    Set ny = y + dy
                    Set natl = 1
                    If dir = "" { Set natl = atl }
                    If (ndir = dir) { Set natl = atl + 1 }

                    //Write *9,*9,visited,!

                    If (visited(x,y) '[ (ndir)) {
                        Do ..Step(nx,ny,maxx,maxy,.map,ndir,natl,path,.paths,.visited)
                    }
                }
            }
    }
    //}
}

ClassMethod CalculateSocre(path) As %Integer
{
    Set score = 0
    Set len = $LENGTH(path)
    For i=2:1:len {
        Set score = score + $EXTRACT(path)
    }
    Return score
}

}
