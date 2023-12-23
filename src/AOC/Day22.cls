Class AOC.Day22 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    While ('..TestFile.AtEnd){
        Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
        set top = $PIECE(line,"~",1)
        set bottom = $PIECE(line,"~",2)
        set brick = $get(brick) + 1
        set topc = $LISTFROMSTRING(top,",")
        set bottomc = $LISTFROMSTRING(bottom,",")
        for x=$LIST(topc,1):1:$LIST(bottomc,1) {
            for y=$LIST(topc,2):1:$LIST(bottomc,2) {
                for z=$LIST(topc,3):1:$LIST(bottomc,3) {
                    set map(y,x,y) = brick
                    set imap(x,y,z) = brick
                }
            }
        }
        set brick(brick) = $LISTBUILD(topc,bottomc)
    }

    

    for b=1:1:brick {
        set c = brick(b)
        set top = $LIST(c,2)
        set bottom = $LIST(c,1)
        set supports = 0
        for x=$LIST(bottom,1):1:$LIST(top,1) {
            for y=$LIST(bottom,1):1:$LIST(top,2) {
                if $ORDER(imap(x,y,$LIST(top,3))) { set supports = 1 }
            }
        }
        if 'supports { 
            set result = result + 1 
            write b,!
        }
    }

    return result
}

}
