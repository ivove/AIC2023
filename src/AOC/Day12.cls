Class AOC.Day12 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set map = $PIECE(line," ",1)
        Set format = $PIECE(line," ",2)
        Set springs(y) = $LISTBUILD(map,format)
        Set y = y + 1
    }
    Set max = y - 1

    For i=1:1:max {
        Set spring = springs(i)
        Set map = $LIST(spring,1)
        Set format = $LIST(spring,2)

        Kill posibilities
        Do ..BuildPos(map,"",1,.posibilities)

        Set atl = 0
        //w map,*9,format,!
        For t=1:1:posibilities {
            Set p = posibilities(t)
            If (..TestFormat(p,format)) { 
                Set atl = atl + 1 
                //w *9,p,!
            }
        }
        //w "***",*9,atl,!
        Set result = result + atl
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set map = $PIECE(line," ",1)
        Set format = $PIECE(line," ",2)
        Set xformat = ""
        Set xmap = ""
        For i=1:1:5{
            Set xformat = xformat_format_","
            Set xmap = xmap_map_"?"
        }
        Set xformat = $EXTRACT(xformat,1,*-1)
        Set xmap = $EXTRACT(xmap,1,*-1)
        Set springs(y) = $LISTBUILD(xmap,xformat)
        Set y = y + 1
    }
    Set max = y - 1

    For i=1:1:max {
        Write i,"/",max,!
        Set spring = springs(i)
        Set map = $LIST(spring,1)
        Set format = $LIST(spring,2)

        Kill posibilities
        Do ..BuildMap(map,"",format,1,.posibilities)

        Set result = result + $GET(posibilities)
    }

    Return result
}

Method Part2b() As %Integer
{
    Set result = 0 
    
    Set y = 1
    Set min = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set map = $PIECE(line," ",1)
        Set format = $PIECE(line," ",2)
        Set xformat = ""
        Set xmap = ""
        For i=1:1:5{
            Set xformat = xformat_format_","
            Set xmap = xmap_map_"?"
        }
        Set xformat = $EXTRACT(xformat,1,*-1)
        Set xmap = $EXTRACT(xmap,1,*-1)

        Set len = $LENGTH(xmap)
        Set p = $EXTRACT(xmap,1)
        Set current = p
        Kill pieces
        For x=2:1:len {
            Set c = $EXTRACT(xmap,x)
            If (c = p) { Set current = current_c }
            Else {
                If p = "?"{
                    If $LENGTH(current)>min { Set min = $LENGTH(current) }
                }
                Set p = c
                Set pieces = $GET(pieces) + 1
                Set pieces(pieces) = current
                Set current = c
            }
        }
        Set pieces = $GET(pieces) + 1
        Set pieces(pieces) = current
        Set springs(y) = $LISTBUILD(xmap,xformat)
        Merge springs(y,"P") = pieces
        Set y = y + 1
    }
    Set max = y - 1
    Do ..BuildFill(min,.fill)

    For i=1:1:max {
        Write i,"/",max,*9
        Kill mp
        Do ..Map(i,.springs,.fill,"",1,.mp)
        Set result = result + mp
        Write mp,!
    }


    Return result
}

ClassMethod Map(nr, springs, fills, current, pnr, maps)
{
    //w current,!
    If (pnr>springs(nr,"P")){
        Set f = ..TranslateMap(current)
        //if $e(current,1,3) = "#.#" { w current,!,f,!,$LIST(springs(nr),2),!,$LIST(springs(nr),1),!,! }
        If (f = $LIST(springs(nr),2)) { 
            Set maps = $GET(maps) + 1
            Set maps(maps) = current
            //w current,!
        }
    } Else {
        Set go = 1
        If ($EXTRACT(current,*) = "."){
            Set f = ..TranslateMap(current)
            If (f '= $EXTRACT($LIST(springs(nr),2),1,$LENGTH(f))) { Set go = 0 }
        }
        If go {
            Set nxt = springs(nr,"P",pnr)
            If ($EXTRACT(nxt,1) = "?"){
                Set l = $LENGTH(nxt)
                For i=1:1:fills(l) {
                    Set nc = current_fills(l,i)
                    //if pnr = 1 w nc,!
                    Do ..Map(nr,.springs,.fills,nc,pnr+1,.maps)
                }
            } Else {
                Set nc = current_nxt
                Do ..Map(nr,.springs,.fills,nc,pnr+1,.maps)
            }
        }
    }
}

ClassMethod BuildFill(atl, fill)
{
    For i=1:1:atl {
        Kill tmp
        Do ..DoBuildFill(i,"",.tmp)
        Merge fill(i)=tmp
    }
}

ClassMethod DoBuildFill(atl, current, fill)
{
    If ($LENGTH(current) = atl) { 
        Set fill = $GET(fill) + 1
        Set fill(fill) = current
    } Else {
        Do ..DoBuildFill(atl,current_".",.fill)
        Do ..DoBuildFill(atl,current_"#",.fill)
    }
}

ClassMethod BuildPos(source, current, position, pos)
{
    If (position <= $LENGTH(source)) {
        Set c = $EXTRACT(source,position)
        If (c = "?") {
            Set n1 = current_"."
            Set n2 = current_"#"
            Do ..BuildPos(source,n1,position+1,.pos)
            Do ..BuildPos(source,n2,position+1,.pos)
        } Else {
            Set next = current_c
            Do ..BuildPos(source,next,position + 1,.pos)
        }
    } Else {
        Set pos = $GET(pos) + 1
        Set pos(pos) = current
    }
}

ClassMethod TestFormat(source, format) As %Boolean [ PublicList = pattern ]
{
    Set pattern = ".""."""
    Set len = $LENGTH(format,",")
    For i=1:1:len {
        Set atl = $PIECE(format,",",i)
        If (i < len) {
            Set pattern = pattern_atl_"""#""1.""."""
        }
        Else {
            Set pattern = pattern_atl_"""#"""
        }

    }
    Set pattern = pattern_".""."""
    If source?@pattern { Set ok = 1 }
    Else { Set ok = 0}
    Return ok
}

ClassMethod GetPattern(format) As %String
{
    Set pattern = ".""."""
    Set len = $LENGTH(format,",")
    For i=1:1:len {
        Set atl = $PIECE(format,",",i)
        If (i < len) {
            Set pattern = pattern_atl_"""#""1.""."""
        }
        Else {
            Set pattern = pattern_atl_"""#"""
        }

    }
    Set pattern = pattern_".""."""
    Return pattern
}

ClassMethod TestPattern(source, pattern) As %Boolean [ PublicList = pattern ]
{
    If source?@pattern { Set ok = 1 }
    Else { Set ok = 0}
    Return ok
}

ClassMethod TranslateMap(map) As %String
{
    Set format = ""
    Set len = $LENGTH(map)
    Set count = 0
    For i=1:1:len {
        Set c = $EXTRACT(map,i)
        If (c = "#") { Set count = count + 1 }
        ElseIf (count '= 0) { 
            Set format = format_count_","
            Set count = 0
        }
    }
    If (count '= 0 ) { Set format = format_count_"," }
    Set format = $EXTRACT(format,1,*-1)
    Return format
}

ClassMethod BuildMap(source, current, format, position, map)
{
    //w current,!
    If (position <= $LENGTH(source)) {
        Set c = $EXTRACT(source,position)
        If (c = "?") {
            Set n1 = current_"."
            Set m1 = ..TranslateMap(n1)
            If (m1 = $EXTRACT(format,1,$LENGTH(m1))) {
                Do ..BuildMap(source,n1,format,position + 1,.map)
            }
            Set n2 = current_"#"            
            Set m2 = ..TranslateMap(n2)
            If ($EXTRACT(m2,*)<=$EXTRACT(format,$LENGTH(m2))) {
                Do ..BuildMap(source,n2,format,position + 1,.map)
            }
            
        } Else {
            Set next = current_c
            Set go = 1
            If (c="#") {   
                Set m = ..TranslateMap(next)
                If ($EXTRACT(m,*)>$EXTRACT(format,$LENGTH(m))) { Set go = 0 }
            }
            If go { Do ..BuildMap(source,next,format,position + 1,.map) }
            
        }
    } Else {
        Set m = ..TranslateMap(current)
        If (m = format) {
            //w "***",current,!
            Set map = $GET(map) + 1
            Set map(map) = current
        }
    }
}

}
