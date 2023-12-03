Class AOC.day1 Extends AOC.Base
{
    Method Part1() As %Integer
    {
        Set result = 0
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set number = ""
            Set len = $LENGTH(line)
            Set i = 1
            While ((i)<=len) && ($LENGTH(number)<2) {
                Set c = $EXTRACT(line,i)
                If (c?1N) { Set number = number_c }
                Set i = i + 1
            }
            Set result = result + number
        }
        Return result
    }
}