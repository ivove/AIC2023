Class AOC.Day12 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set map = $PIECE(line," ",1)
        set format = $PIECE(line," ",2)
        set springs(y) = $LISTBUILD(map,format)
        set y = y + 1
    }
    set max = y - 1

    for i=1:1:max {
        set spring = springs(i)
        set map = $LIST(spring,1)
        set format = $LIST(spring,2)

        kill posibilities
        do ..BuildPos(map,"",1,.posibilities)

        set atl = 0
        //w map,*9,format,!
        for t=1:1:posibilities {
            set p = posibilities(t)
            if (..TestFormat(p,format)) { 
                set atl = atl + 1 
                //w *9,p,!
            }
        }
        //w "***",*9,atl,!
        set result = result + atl
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set map = $PIECE(line," ",1)
        set format = $PIECE(line," ",2)
        set xformat = ""
        set xmap = ""
        for i=1:1:5{
            set xformat = xformat_format_","
            set xmap = xmap_map_"?"
        }
        set xformat = $EXTRACT(xformat,1,*-1)
        set xmap = $EXTRACT(xmap,1,*-1)
        set springs(y) = $LISTBUILD(xmap,xformat)
        set y = y + 1
    }
    set max = y - 1

    for i=1:1:max {
        w i,"/",max,!
        set spring = springs(i)
        set map = $LIST(spring,1)
        set format = $LIST(spring,2)

        kill posibilities
        do ..BuildMap(map,"",format,1,.posibilities)

        set result = result + $get(posibilities)
    }

    Return result
}

Method Part2b() As %Integer
{
    Set result = 0 
    
    Set y = 1
    set min = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set map = $PIECE(line," ",1)
        set format = $PIECE(line," ",2)
        set xformat = ""
        set xmap = ""
        for i=1:1:5{
            set xformat = xformat_format_","
            set xmap = xmap_map_"?"
        }
        set xformat = $EXTRACT(xformat,1,*-1)
        set xmap = $EXTRACT(xmap,1,*-1)

        set len = $LENGTH(xmap)
        set p = $EXTRACT(xmap,1)
        set current = p
        kill pieces
        for x=2:1:len {
            set c = $EXTRACT(xmap,x)
            if (c = p) { set current = current_c }
            else {
                if p = "?"{
                    if $LENGTH(current)>min { set min = $LENGTH(current) }
                }
                set p = c
                set pieces = $GET(pieces) + 1
                set pieces(pieces) = current
                set current = c
            }
        }
        set pieces = $GET(pieces) + 1
        set pieces(pieces) = current
        set springs(y) = $LISTBUILD(xmap,xformat)
        merge springs(y,"P") = pieces
        set y = y + 1
    }
    set max = y - 1
    do ..BuildFill(min,.fill)

    for i=1:1:max {
        w i,"/",max,*9
        kill mp
        do ..Map(i,.springs,.fill,"",1,.mp)
        set result = result + mp
        w mp,!
    }


    Return result
}

ClassMethod Map(nr, springs, fills, current, pnr, maps)
{
    //w current,!
    if (pnr>springs(nr,"P")){
        s f = ..TranslateMap(current)
        //if $e(current,1,3) = "#.#" { w current,!,f,!,$LIST(springs(nr),2),!,$LIST(springs(nr),1),!,! }
        if (f = $LIST(springs(nr),2)) { 
            set maps = $GET(maps) + 1
            set maps(maps) = current
            //w current,!
        }
    } else {
        set go = 1
        if ($EXTRACT(current,*) = "."){
            s f = ..TranslateMap(current)
            if (f '= $EXTRACT($LIST(springs(nr),2),1,$LENGTH(f))) { set go = 0 }
        }
        if go {
            set nxt = springs(nr,"P",pnr)
            if ($EXTRACT(nxt,1) = "?"){
                set l = $LENGTH(nxt)
                for i=1:1:fills(l) {
                    set nc = current_fills(l,i)
                    //if pnr = 1 w nc,!
                    do ..Map(nr,.springs,.fills,nc,pnr+1,.maps)
                }
            } else {
                set nc = current_nxt
                do ..Map(nr,.springs,.fills,nc,pnr+1,.maps)
            }
        }
    }
}

ClassMethod BuildFill(atl, fill)
{
    for i=1:1:atl {
        kill tmp
        d ..DoBuildFill(i,"",.tmp)
        merge fill(i)=tmp
    }
}

ClassMethod DoBuildFill(atl, current, fill)
{
    if ($LENGTH(current) = atl) { 
        set fill = $get(fill) + 1
        set fill(fill) = current
    } else {
        do ..DoBuildFill(atl,current_".",.fill)
        do ..DoBuildFill(atl,current_"#",.fill)
    }
}

ClassMethod BuildPos(source, current, position, pos)
{
    if (position <= $LENGTH(source)) {
        set c = $EXTRACT(source,position)
        if (c = "?") {
            set n1 = current_"."
            set n2 = current_"#"
            do ..BuildPos(source,n1,position+1,.pos)
            do ..BuildPos(source,n2,position+1,.pos)
        } else {
            set next = current_c
            do ..BuildPos(source,next,position + 1,.pos)
        }
    } else {
        set pos = $get(pos) + 1
        set pos(pos) = current
    }
}

ClassMethod TestFormat(source, format) As %Boolean [ PublicList = pattern ]
{
    set pattern = ".""."""
    set len = $LENGTH(format,",")
    for i=1:1:len {
        set atl = $PIECE(format,",",i)
        if (i < len) {
            set pattern = pattern_atl_"""#""1.""."""
        }
        else {
            set pattern = pattern_atl_"""#"""
        }

    }
    set pattern = pattern_".""."""
    if source?@pattern { set ok = 1 }
    else { set ok = 0}
    Return ok
}

ClassMethod GetPattern(format) As %String
{
    set pattern = ".""."""
    set len = $LENGTH(format,",")
    for i=1:1:len {
        set atl = $PIECE(format,",",i)
        if (i < len) {
            set pattern = pattern_atl_"""#""1.""."""
        }
        else {
            set pattern = pattern_atl_"""#"""
        }

    }
    set pattern = pattern_".""."""
    Return pattern
}

ClassMethod TestPattern(source, pattern) As %Boolean [ PublicList = pattern ]
{
    if source?@pattern { set ok = 1 }
    else { set ok = 0}
    Return ok
}

ClassMethod TranslateMap(map) As %String
{
    set format = ""
    set len = $LENGTH(map)
    set count = 0
    for i=1:1:len {
        set c = $EXTRACT(map,i)
        if (c = "#") { set count = count + 1 }
        elseif (count '= 0) { 
            set format = format_count_","
            set count = 0
        }
    }
    if (count '= 0 ) { set format = format_count_"," }
    set format = $EXTRACT(format,1,*-1)
    return format
}

ClassMethod BuildMap(source, current, format, position, map)
{
    //w current,!
    if (position <= $LENGTH(source)) {
        set c = $EXTRACT(source,position)
        if (c = "?") {
            set n1 = current_"."
            set m1 = ..TranslateMap(n1)
            if (m1 = $EXTRACT(format,1,$LENGTH(m1))) {
                do ..BuildMap(source,n1,format,position + 1,.map)
            }
            set n2 = current_"#"            
            set m2 = ..TranslateMap(n2)
            if ($EXTRACT(m2,*)<=$EXTRACT(format,$LENGTH(m2))) {
                do ..BuildMap(source,n2,format,position + 1,.map)
            }
            
        } else {
            set next = current_c
            set go = 1
            if (c="#") {   
                set m = ..TranslateMap(next)
                if ($EXTRACT(m,*)>$EXTRACT(format,$LENGTH(m))) { set go = 0 }
            }
            if go { do ..BuildMap(source,next,format,position + 1,.map) }
            
        }
    } else {
        set m = ..TranslateMap(current)
        if (m = format) {
            //w "***",current,!
            set map = $get(map) + 1
            set map(map) = current
        }
    }
}

}
