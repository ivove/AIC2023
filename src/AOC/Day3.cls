Class AOC.Day3 Extends AOC.Base
{

Method Part1() As %Integer
{
    set result = 0
    set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set p = ""
        set num = ""
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            
            set map(x,y) = c

            if (c?1N) { set num = num_c }
            elseif (p?1N) {
                set numbers = $GET(numbers) + 1
                set numbers(numbers) = $LISTBUILD(num,x-$LENGTH(num),y)
                set num = "" 
            }
            set p = c
        }
        if (num '= "") {
            set numbers = $GET(numbers) + 1
            set numbers(numbers) = $LISTBUILD(num,x-$LENGTH(num)+1,y)
            if num = 941 {
                write "*",num,"*",*9,x-$LENGTH(num),!
            }
        }
        set y = y + 1
    }

    set zz = 0
    for i=1:1:numbers {
        set num = $LIST(numbers(i),1)
        set x = $LIST(numbers(i),2)
        set y = $LIST(numbers(i),3)
        set fromx = x - 1
        set fromy = y - 1
        set toy = y + 1
        set tox = x + $LENGTH(num)
        set add = 0
        //write "checking: ",i," - ",num,!
        for ty=fromy:1:toy {
            for tx=fromx:1:tox {
                if $DATA(map(tx,ty)) {
                    //w map(tx,ty)
                    set check = 1
                    if (ty = y) {
                        if ((tx'=fromx) && (tx'=tox)) { set check = 0 }
                    }
                    if check {
                        if ((map(tx,ty)'=".")) { set add = 1 }
                    }
                }
            }
            //w !
        }
        //530595 -> only check symbols -> wrong
        //531491 -> also check numbers -> wrong
        if add { 
            set result = result + num 
            //write "**is part, adding ",num," to result to obtain ", result,!
        } else { 
            //write "--is not part",! 
        }

        set zz = zz + 1
        if zz = 10 {
            //read xx
            set zz = 0
        }
    }

    Return result
}

Method Part1x() As %Integer
{
        Set result = 0
        Set y = 1
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set len = $LENGTH(line)
            Set p="."
            Set num = ""
            For i=1:1:len {
                Set c = $EXTRACT(line,i)
                Set map(y,i)=c
                If ((c?1N))
                {
                    Set num = num_c
                }
                If ('((c?1N)) && (p?1N)){
                    Set nums(num) = $LISTBUILD(i,y)
                    Set num = ""
                }
                Set p = c
                If num'="" {Set nums(num)=$LISTBUILD(i,y)}
            }
            Set y = y + 1
        }
        Set num = $ORDER(nums(""),1,value)
        While num'="" {
            Set len = $LENGTH(num)
            Set fnd = 0
            Set myx =$LIST(value,1)
            Set myy = $LIST(value,2)
            Set fromx = myx-len-1
            Set tox = myx
            Set fromy = myy-1
            Set toy = myy+1
            For y=fromy:1:toy {
                For x=fromx:1:tox{
                    If ($DATA(map(y,x))) {
                        If ((y=myy) && (x'=fromx) && (x'=tox)) {}
                        Else {
                            If num=446 { Write num,*9,y,*9,x,*9,map(y,x),! }
                            If ((map(y,x)'=".") && ('(map(y,x)?1N))) { Set fnd = 1 }
                        }
                    }
                }
            }
            If (fnd=1) { 
                Set result = result + num 
                Write "***",num,!
            }
            ZWrite map(446)
            Set num = $ORDER(nums(num),1,value)
        }
        Return result
}

Method Part2() As %Integer
{
    set result = 0
    set y = 1
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set len = $LENGTH(line)
        set p = ""
        set num = ""
        for x=1:1:len {
            set c = $EXTRACT(line,x)
            
            set map(x,y) = c

            if (c?1N) { set num = num_c }
            elseif (p?1N) {
                set numbers = $GET(numbers) + 1
                set numbers(numbers) = $LISTBUILD(num,x-$LENGTH(num),y)
                set num = "" 
            }

            if (c="*") {
                set gears = $GET(gears) + 1
                set gears(gears) = $LISTBUILD(x,y)
            }

            set p = c
        }
        if (num '= "") {
            set numbers = $GET(numbers) + 1
            set numbers(numbers) = $LISTBUILD(num,x-$LENGTH(num)+1,y)
        }
        set y = y + 1
    }

    set zz = 0
    for i=1:1:gears {
        set x = $LIST(gears(i),1)
        set y = $LIST(gears(i),2)
        set fromx = x - 1
        set fromy = y - 1
        set toy = y + 1
        set tox = x + 1
        set add = 1
        set fnd = 0
        kill done
        //write "checking: ",i," - ",num,!
        for ty=fromy:1:toy {
            for tx=fromx:1:tox {
                if ($DATA(map(tx,ty)) && '$DATA(done(tx,ty))) {
                    //w map(tx,ty)
                    if (map(tx,ty)?1N){
                        set fnd = fnd + 1
                        set n = map(tx,ty)
                        set num = n
                        set xad = -1
                        if $DATA(map(tx+xad,ty)) {
                            set n = map(tx+xad,ty)
                            while n?1N {
                                set done(tx+xad,ty)=""
                                set num = n_num
                                set xad = xad - 1
                                if $DATA(map(tx+xad,ty)) {
                                    set n = map(tx+xad,ty)
                                } else { set n ="" }
                            }
                        }
                        set xad = 1
                        if $DATA(map(tx+xad,ty)) {
                            set n = map(tx+xad,ty)
                            while n?1N {
                                set done(tx+xad,ty)=""
                                set num = num_n
                                set xad = xad + 1
                                if $DATA(map(tx+xad,ty)) {
                                    set n = map(tx+xad,ty)
                                } else { set n ="" }
                            }
                        }
                        set add = add * num
                    }
                }
            }
            //w !
        }
        //530595 -> only check symbols -> wrong
        //531491 -> also check numbers -> wrong
        if fnd = 2 { 
            set result = result + add 
            //write "**is part, adding ",num," to result to obtain ", result,!
        } else { 
            //write "--is not part",! 
        }

        set zz = zz + 1
        if zz = 10 {
            //read xx
            set zz = 0
        }
    }

    Return result
}

}
