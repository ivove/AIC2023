Class AOC.day1 Extends AOC.Base
{

Method Part1() As %Integer
{
        Set result = 0 
        //Write !,"1"
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set number = ""
            Set len = $LENGTH(line)
            Set i = 1
            Set last = ""
            While ((i)<=len) {
                Set c = $EXTRACT(line,i)
                If (c?1N) { 
                    If (last = "" ) { Set number = number_c }
                    Set last = c    
                }
                Set i = i + 1
            }
            Set number = number_last
            Write line,*9,number,!
            Set result = result + number
        }
        Return result
}

Method Part2(test As %Boolean = 0) As %Integer
{
        Set result = 0 
        //Write !,"1"
        If (test = 0) {
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Write line,*9
            Set line = ..replace(line)
            Set number = ""
            Set len = $LENGTH(line)
            Set i = 1
            Set last = ""
            While ((i)<=len) {
                Set c = $EXTRACT(line,i)
                If (c?1N) { 
                    If (last = "" ) { Set number = number_c }
                    Set last = c    
                }
                Set i = i + 1
            }
            Set number = number_last
            Write line,*9,number,!
            Set result = result + number
        }
        }
        Else {
            While ('..TestFile.AtEnd){
            Set line = $TRANSLATE(..TestFile.ReadLine(),$CHAR(13),"")
            Set line = ..replace(line)
            Set number = ""
            Set len = $LENGTH(line)
            Set i = 1
            Set last = ""
            While ((i)<=len) {
                Set c = $EXTRACT(line,i)
                If (c?1N) { 
                    If (last = "" ) { Set number = number_c }
                    Set last = c    
                }
                Set i = i + 1
            }
            Set number = number_last
            Write line,*9,number,!
            Set result = result + number
        }
        }
        Return result
}

Method replace(input As %String)
{
    Set output = input
    Set todo = $LISTBUILD("one","two","three","four","five","six","seven","eight","nine")
    Set len = $LENGTH(output)
    Set i = 1
    While (i<len) {        
        For y=1:1:$LISTLENGTH(todo) {
            Set digit = $LIST(todo,y)
            //Write $EXTRACT(output,i,i+$LENGTH(digit)-1),*9,digit,!
            If (($EXTRACT(output,i,i+$LENGTH(digit)-1)) = digit){
                Set output = $EXTRACT(output,0,i-1)_y_$EXTRACT(output,i+1,*)
                //Write "***",output,!
                Set len = $LENGTH(output)
            }
        }
        Set i = i + 1
    }
    Return output
}

}
