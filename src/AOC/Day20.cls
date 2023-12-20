Class AOC.Day20 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    set low = 0
    set high = 0
    
    Set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set type = $EXTRACT(line,1)
        set name = $PIECE(line," ",1)
        if (type '= "b") {
            set name = $EXTRACT(name,2,*)
        }
        set out = $TRANSLATE($PIECE(line,">",2)," ","")
        set outlst = $LISTFROMSTRING(out,",")
        set parts(name) = $LISTBUILD(type,outlst)
        if type = "%" { set state(name) = 0 }
        for n=1:1:$LISTLENGTH(outlst) {
            set state($LIST(outlst,n),name) = 0
        }
    }

    set low = 0
    for i=1:1:1000 {
        kill n
        set n(1) = $listbuild("broadcaster",0,"")
        set n=1
        set low = low + 1
        set x = $ORDER(n(""),1,val)
        while x '= "" {
            set name = $list(val,1)
            set pulse = $list(val,2)
            set from = $list(val,3)
            if $DATA(parts(name)) {
                set out = $LIST(parts(name),2)
                set type = $LIST(parts(name),1)
                if (type = "b") {
                    for o=1:1:$LISTLENGTH(out) {
                        set low = low + 1
                        set n = n + 1
                        set n(n) = $LISTBUILD($LIST(out,o),0,name)
                        //write name_" -> low - ",$LIST(out,o),!
                    }
                } ElseIf (type = "%") {
                    if ('pulse) {
                        set state(name) = 'state(name)
                        set npulse = state(name)
                        for o=1:1:$LISTLENGTH(out) {
                            if npulse { set high = high + 1}
                            else { set low = low + 1 }
                            set n = n + 1
                            set n(n) = $LISTBUILD($LIST(out,o),npulse,name)
                            //write name_" -> "_$SELECT(npulse:"high",1:"low")_" - ",$LIST(out,o),!
                        }
                    }
                } else {
                    set state(name,from) = pulse
                    set npulse = 1
                    set allhigh = 1
                    set xf = $ORDER(state(name,""))
                    while (xf '= "") {
                        if (state(name,xf) = 0) { set allhigh = 0 }
                        set xf = $ORDER(state(name,xf))
                    }
                    if allhigh { set npulse = 0 }
                    for o=1:1:$LISTLENGTH(out) {
                        if npulse { set high = high + 1}
                        else { set low = low + 1 }
                        set n = n + 1
                        set n(n) = $LISTBUILD($LIST(out,o),npulse,name)
                        //write name_" -> "_$SELECT(npulse:"high",1:"low")_" - ",$LIST(out,o),!
                    }
                }
            }
            set x = $ORDER(n(x),1,val)
        }
        kill n
        merge n = nn
    }

    set result = high * low
    return result
}

Method Part2() As %Integer
{
    Set result = 0 
    set low = 0
    set high = 0
    
    Set y = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set type = $EXTRACT(line,1)
        set name = $PIECE(line," ",1)
        if (type '= "b") {
            set name = $EXTRACT(name,2,*)
        }
        set out = $TRANSLATE($PIECE(line,">",2)," ","")
        set outlst = $LISTFROMSTRING(out,",")
        set parts(name) = $LISTBUILD(type,outlst)
        if type = "%" { set state(name) = 0 }
        for n=1:1:$LISTLENGTH(outlst) {
            set state($LIST(outlst,n),name) = 0
        }
    }

    set low = 0
    set cont = 1
    while cont {
        set y = y + 1
        kill n
        set n(1) = $listbuild("broadcaster",0,"")
        set n=1
        set low = low + 1
        set x = $ORDER(n(""),1,val)
        while x '= "" {
            set name = $list(val,1)
            set pulse = $list(val,2)
            set from = $list(val,3)
            if $DATA(parts(name)) {
                set out = $LIST(parts(name),2)
                set type = $LIST(parts(name),1)
                if (type = "b") {
                    for o=1:1:$LISTLENGTH(out) {
                        set low = low + 1
                        set n = n + 1
                        set n(n) = $LISTBUILD($LIST(out,o),0,name)
                        if ($LIST(out,o) = "rx") { set cont = 0 }
                        //write name_" -> low - ",$LIST(out,o),!
                    }
                } ElseIf (type = "%") {
                    if ('pulse) {
                        set state(name) = 'state(name)
                        set npulse = state(name)
                        for o=1:1:$LISTLENGTH(out) {
                            if npulse { set high = high + 1}
                            else { set low = low + 1 }
                            set n = n + 1
                            set n(n) = $LISTBUILD($LIST(out,o),npulse,name)
                            if (($LIST(out,o) = "rx") && 'npulse) { set cont = 0 }
                            //write name_" -> "_$SELECT(npulse:"high",1:"low")_" - ",$LIST(out,o),!
                        }
                    }
                } else {
                    set state(name,from) = pulse
                    set npulse = 1
                    set allhigh = 1
                    set xf = $ORDER(state(name,""))
                    while (xf '= "") {
                        if (state(name,xf) = 0) { set allhigh = 0 }
                        set xf = $ORDER(state(name,xf))
                    }
                    if allhigh { set npulse = 0 }
                    for o=1:1:$LISTLENGTH(out) {
                        if npulse { set high = high + 1}
                        else { set low = low + 1 }
                        set n = n + 1
                        set n(n) = $LISTBUILD($LIST(out,o),npulse,name)
                        if (($LIST(out,o) = "rx") && 'npulse) { set cont = 0 }
                        //write name_" -> "_$SELECT(npulse:"high",1:"low")_" - ",$LIST(out,o),!
                    }
                }
            }
            set x = $ORDER(n(x),1,val)
        }
        
    }

    set result = y
    return result
}

}
