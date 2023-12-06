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
            set numbers(numbers) = $LISTBUILD(num,x-$LENGTH(num),y)
        }
        set y = y + 1
    }

    for i=1:1:numbers {
        set num = $LIST(numbers(i),1)
        set x = $LIST(numbers(i),2)
        set y = $LIST(numbers(i),3)
        set fromx = x - 1
        set fromy = y - 1
        set toy = y + 1
        set tox = x + $LENGTH(num)
        set add = 0
        for ty=fromy:1:toy {
            for tx=fromx:1:tox {
                if $DATA(map(tx,ty)) {
                    w map(tx,ty)
                    set check = 1
                    if (ty = y) {
                        if ((tx'=fromx) && (tx'=tox)) { set check = 0 }
                    }
                    if check {
                        if ((map(tx,ty)'=".")) { set add = 1 }
                    }
                }
            }
            w !
        }
        //530595 -> only check symbols -> wrong
        //531491 -> also check numbers -> wrong
        if add { set result = result + num }
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

}
