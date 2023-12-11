Class AOC.Day12 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
        
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
    }
    Return result
}

}
