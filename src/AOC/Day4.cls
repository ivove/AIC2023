Class AOC.Day4 Extends AOC.Base
{

Method Part1() As %Integer
{
        Set result = 0
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set wins = $PIECE($PIECE(line,": ",2)," | ",1)
            Set mys = $PIECE(line," | ",2)
            Kill win,my
            For i=1:1:$LENGTH(wins," ") {
                If $PIECE(wins," ",i) '= "" {
                    Set win($PIECE(wins," ",i)) = ""
                }
            }
            For i=1:1:$LENGTH(mys," ") {
                If $PIECE(mys," ",i)'="" {
                    Set my($PIECE(mys," ",i)) = ""
                }
            }
            Set value = 0
            Set t = $ORDER(my(""))
            While t '= "" {
                If $DATA(win(t)) {
                    If value = 0 { Set value = 1 }
                    Else { Set value = value * 2 }
                }
                Set t=$ORDER(my(t))
            }
            Set result = result + value
        }
        Return result
}

Method Part2() As %Integer
{
        Set result = 0
        Set id = 1
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set wins = $PIECE($PIECE(line,": ",2)," | ",1)
            Set mys = $PIECE(line," | ",2)
            For i=1:1:$LENGTH(wins," ") {
                If $PIECE(wins," ",i) '= "" {
                    Set cards(id,"w",$PIECE(wins," ",i)) = ""
                }
            }
            For i=1:1:$LENGTH(mys," ") {
                If $PIECE(mys," ",i)'="" {
                    Set cards(id,"m",$PIECE(mys," ",i)) = ""
                }
            }
            Set numWins = 0
            Set t = $ORDER(cards(id,"m",""))
            While t '= "" {
                If $DATA(cards(id,"w",t)) {
                    Set numWins = numWins + 1
                }
                Set t=$ORDER(cards(id,"m",t))
            }
            Set cards(id,"x") = numWins
            Set numcards(id) = 1
            Set id = id + 1
        }
        //ZWrite cards
        Set id = $ORDER(cards(""))
        While id '= "" {
            Set numWins = cards(id,"x")
            Set addcards = numcards(id)
            //Write id,*9,numWins,*9,addcards,!
            For i=1:1:numWins {
                //Write "***",*9,id+i,*9,addcards,!
                If $DATA(numcards(id+i)) {
                    Set numcards(id+i) = numcards(id+i) + addcards
                }
            }
            Set id = $ORDER(cards(id))
        }
        Set id = $ORDER(numcards(""),1,val)
        While id '= "" {
            Set result = result + val
            Set id = $ORDER(numcards(id),1,val)
        }

        Return result
}

}
