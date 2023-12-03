Class AOC.Day2 Extends AOC.Base
{

Method Part1() As %Integer
{
    //only 12 red cubes, 13 green cubes, and 14 blue cubes
    Set stones("red") = 12
    Set stones("green") = 13
    Set stones("blue") = 14
    Set result = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set id = $PIECE($PIECE(line,":")," ",2)
        Set games = $LISTFROMSTRING($PIECE(line,":",2),";")
        Set valid = 1
        For i=1:1:$LISTLENGTH(games) {
            Set draws = $LISTFROMSTRING($LIST(games,i),",")
            For d=1:1:$LISTLENGTH(draws) {
                Set draw = $LIST(draws,d)
                If (stones($PIECE(draw," ",3))<$PIECE(draw," ",2)){ Set valid = 0 }
            }
        }
        If valid { Set result = result + id }
    }
    Return result
}

Method Part2() As %Integer
{
    //only 12 red cubes, 13 green cubes, and 14 blue cubes
    Set result = 0
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        Set s("red") = 0
        Set s("blue") = 0
        Set s("green") = 0
        Set games = $LISTFROMSTRING($PIECE(line,":",2),";")
        Set valid = 1
        For i=1:1:$LISTLENGTH(games) {
            Set draws = $LISTFROMSTRING($LIST(games,i),",")
            For d=1:1:$LISTLENGTH(draws) {
                Set draw = $LIST(draws,d)
                Set color = $PIECE(draw," ",3)
                Set number = $PIECE(draw," ",2)
                If (s(color)<number) { Set s(color) = number }
            }
        }
        Set power = s("red") * s("green") * s("blue")
        Set result = result + power
    }
    Return result
}

}
