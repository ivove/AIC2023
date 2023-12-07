Class AOC.Day7 Extends AOC.Base
{

Method Part1()
{
        Set result = 0
        Set y = 1
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            kill cnt

            set hand = $PIECE(line," ",1)
            set bet = $PIECE(line," ",2)

            set len = $LENGTH(hand)
            for i=1:1:len {
                set c = $EXTRACT(hand,i)
                set cnt(c) = $GET(cnt(c)) + 1
            }

            set type = ..GetType(.cnt)
            set list(hand) = type

            set sort = $TRANSLATE(hand,"23456789TJQKA","BCDEFGHILMNOP")
            set sorted(type,sort) = $LISTBUILD(hand,bet)
        }

        set rank = 1
        for t="high","pair","two","three","full","four","five" {
            set s = $ORDER(sorted(t,""))
            while s '= "" {
                set bet = $LIST(sorted(t,s),2)
                set hand = $LIST(sorted(t,s),1)
                //write rank,*9,hand,*9,(rank * bet),!
                set result = result + (rank * bet)
                set rank = rank + 1
                set s = $ORDER(sorted(t,s))
            }
        }

        //zw sorted
        Return result
}

Method Part2()
{
        Set result = 0
        Set y = 1
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            kill cnt

            set hand = $PIECE(line," ",1)
            set bet = $PIECE(line," ",2)

            set len = $LENGTH(hand)
            for i=1:1:len {
                set c = $EXTRACT(hand,i)
                set cnt(c) = $GET(cnt(c)) + 1
            }

            set type = ..GetType(.cnt)

            if ($DATA(cnt("J"))) {
                if (type = "four") {
                    set type = "five"
                }
                elseif (type = "full") {
                    set type = "five"
                }
                elseif (type = "three") {
                    set type = "four"
                }
                elseif (type = "two") {
                    if (cnt("J") = 2) { set type = "four" }
                    else { set type = "full" }
                }
                elseif (type = "pair") { set type = "three" }
                else { set type = "pair" }
            }

            set list(hand) = type

            set sort = $TRANSLATE(hand,"23456789TJQKA","CDEFGHILMBNOP")
            set sorted(type,sort) = $LISTBUILD(hand,bet)
        }

        //zw list

        set rank = 1
        for t="high","pair","two","three","full","four","five" {
            set s = $ORDER(sorted(t,""))
            while s '= "" {
                set bet = $LIST(sorted(t,s),2)
                set hand = $LIST(sorted(t,s),1)
                //write rank,*9,hand,*9,(rank * bet),!
                set result = result + (rank * bet)
                set rank = rank + 1
                set s = $ORDER(sorted(t,s))
            }
        }

        zw sorted("high")

        Return result
}

ClassMethod GetType(ByRef cnt) As %String
{
    set type = "high"
    set c = $ORDER(cnt(""))
    if (cnt(c) = 5) { set type = "five" }
    elseif (cnt(c) = 4) { set type = "four" }
    else {
        if (cnt(c) = 3) {
            set nc = $ORDER(cnt(c))
            if (cnt(nc) = 2) { set type = "full" }
            else { set type = "three" }
        } elseif (cnt(c) = 2) {
            set nc = $ORDER(cnt(c))
            if (cnt(nc) = 3) { set type = "full" }
            elseif (cnt(nc) = 2) { set type = "two" }
            else {
                set type = "pair"
                set nnc = $ORDER(cnt(nc))
                if (cnt(nnc) = 2) { set type = "two" }
            } 
        } else {
            set nc = $ORDER(cnt(c))
            if (cnt(nc) = 4) { set type = "four"}
            elseif (cnt(nc) = 3) { set type = "three"}
            elseif (cnt(nc) = 2) {
                set nnc = $ORDER(cnt(nc))
                if (cnt(nnc) = 2) { set type = "two" }
                else { set type = "pair"}
            } else {
                set nnc = $ORDER(cnt(nc))
                if (cnt(nnc) = 3) { set type = "three" }
                elseif (cnt(nnc) = 2) { set type = "pair" }
                else {
                    set nnnc = $o(cnt(nnc))
                    if (cnt(nnnc) = 2 ) { set type = "pair" }
                }
            }
        }
    }
    return type
}

}
