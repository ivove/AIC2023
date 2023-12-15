Class AOC.Day15 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line,",")
        for i=1:1:len {
            set word = $PIECE(line,",",i)
            set hash = ..GetHash(word)
            //write word,*9,hash,!
            set result = result + hash
        }
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 

    for i=0:1:256 {
        set boxes(i) = $LISTBUILD(0)
    }
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line,",")
        for i=1:1:len {
            set word = $PIECE(line,",",i)
            set label = $PIECE($PIECE(word,"-"),"=")
            set boxnr = ..GetHash(label)
            if (word [ "=") {
                set list = $GET(boxes(boxnr))
                if (list '= "") {
                    if ('$LISTFIND(boxes(boxnr),label)) {
                        set $LIST(list,$LISTLENGTH(list)+1) = label
                    } 
                } else { set list = $LISTBUILD(label) }
                set boxes(boxnr) = list
                set values(label) = $PIECE(word,"=",2)
            } else {
                set list = $get(boxes(boxnr))
                if (list '= "") {
                    set nlist = $LISTBUILD()
                    set cnt = 1
                    for j=1:1:$LISTLENGTH(list) {
                        if ($LISTGET(list,j) '= label) {
                            set $LIST(nlist,cnt) = $LISTGET(list,j)
                            set cnt = cnt + 1
                        }
                    }
                    set boxes(boxnr) = nlist
                }
            }
        }
    }
    zw boxes
    for b=0:1:256 {
        if $DATA(boxes(b)) {
            for x=2:1:$LISTLENGTH(boxes(b)) {
                set label = $LISTGET(boxes(b),x)
                if (label '= "") {
                    set len = values(label)
                    set result = result + ((b + 1) * (x- 1) * len)
                    write b,*9,x,*9,len,*9,label,*9,((b + 1) * (x - 1) * len),!
                }
            }
        }
    }

    Return result
}

ClassMethod GetHash(word) As %Integer
{
    set hash = 0
    set len = $LENGTH(word)
    for i=1:1:len {
        set c = $EXTRACT(word,i)
        set ascii = $ASCII(c)
        set hash = hash + ascii
        set hash = hash * 17
        set hash = hash # 256
    }
    Return hash
}

}
