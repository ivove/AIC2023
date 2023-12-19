Class AOC.Day19 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        if (line = "") { set y = 2 }
        else {
            if (y = 1){
                //instructions
                set name = $PIECE(line,"{")
                set instructions = $PIECE($PIECE(line,"{",2),"}",1)
                set len  = $LENGTH(instructions,",")
                for i=1:1:len {
                    set xx = $PIECE(instructions,",",i)
                    if (xx [ ":") {
                        set programm(name,i) = $LISTBUILD($PIECE(xx,":",2),$PIECE(xx,":",1))
                    } else {
                        set programm(name,i) = $LISTBUILD(xx)
                    }
                }
            } else {
                //parts
                set line = $EXTRACT(line,2,*-1)
                set len = $LENGTH(line,",")
                set parts = $GET(parts) + 1
                for i=1:1:len {
                    set xx = $PIECE(line,",",i)
                    set parts(parts,$PIECE(xx,"=")) = $PIECE(xx,"=",2)
                }
            }
        }
    }

    for p=1:1:parts {
        set a = parts(p,"a")
        set x = parts(p,"x")
        set m = parts(p,"m")
        set s = parts(p,"s")
        set next = "in"
        while ("AR" '[ next) {
            set cont = 1
            set ins = $ORDER(programm(next,""))
            while (cont && (ins '= "")) {
                if $LISTLENGTH(programm(next,ins)) = 2 {
                    set exp = $LIST(programm(next,ins),2)
                    if ..Evaluate(x,m,a,s,exp) {
                        set cont = 0
                        set next = $LIST(programm(next,ins),1)
                    }
                } else {
                    set next = $LIST(programm(next,ins),1)
                    set cont = 0
                }
                set ins = $ORDER(programm(next,ins))
            }
        }
        if next = "A" { merge a(p) = parts(p) }
        else { merge r(p) = parts(p) }
    }

    set p = $ORDER(a(""))
    while p '= "" {
        set x = $ORDER(a(p,""),1,val)
        while x '= "" {
            set result = result + val
            set x = $ORDER(a(p,x),1,val)
        }
        set p = $ORDER(a(p))
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 
    
    Set y = 1
    While ('..TestFile.AtEnd && (y < 2)){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        if (line = "") { set y = 2 }
        else {
            if (y = 1){
                //instructions
                set name = $PIECE(line,"{")
                set instructions = $PIECE($PIECE(line,"{",2),"}",1)
                set len  = $LENGTH(instructions,",")
                for i=1:1:len {
                    set xx = $PIECE(instructions,",",i)
                    if (xx [ ":") {
                        set programm(name,i) = $LISTBUILD($PIECE(xx,":",2),$PIECE(xx,":",1))
                    } else {
                        set programm(name,i) = $LISTBUILD(xx)
                    }
                }
            }
        }
    }

    for a=1:1:4000 {
        for x=1:1:4000{
            for m=1:1:4000 {
                for s=1:1:4000{
                    set next = "in"
                    while ("AR" '[ next) {
                        set cont = 1
                        set ins = $ORDER(programm(next,""))
                        while (cont && (ins '= "")) {
                            if $LISTLENGTH(programm(next,ins)) = 2 {
                                set exp = $LIST(programm(next,ins),2)
                                if ..Evaluate(x,m,a,s,exp) {
                                    set cont = 0
                                    set next = $LIST(programm(next,ins),1)
                                }
                            } else {
                                set next = $LIST(programm(next,ins),1)
                                set cont = 0
                            }
                            set ins = $ORDER(programm(next,ins))
                        }
                    }
                }
            }
        }
        
        if next = "A" { set result = result + 1 }
    }

    Return result
}

ClassMethod Evaluate(x, m, a, s, exp) As %Boolean [ PublicList = (x, m, s, a, exp) ]
{
    return @exp
}

}
