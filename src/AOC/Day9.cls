Class AOC.Day9 Extends AOC.Base
{

Method Part1() As %Integer
{
    Set result = 0 
    
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"") 

        
        Set list = 1
        Set list(list) = line
        Set cont = 1
        While cont {
            Set len = $LENGTH(line," ")
            Set nline = ""
            For i=2:1:len {
                Set a = $PIECE(line," ",i-1)
                Set b = $PIECE(line," ",i)
                Set c = b - a
                Set nline = nline_c_" "
            }
            Set line = $EXTRACT(nline,1,*-1)
            Set list = list + 1
            Set list(list) = line
            If ($TRANSLATE(line," 0") = "") {
                Set cont = 0
            }
        }

        For i=list:-1:2 {
            Set line =list(i)
            Set a = $PIECE(line," ",$LENGTH(line," "))
            Set pline = list(i-1)
            Set b = $PIECE(pline," ",$LENGTH(pline," "))
            Set c = (a + b)
            //Write line,*9,a,*9,b,*9,c,*9,!
            Set pline = pline _ " "_c
            Set list(i-1) = pline
            If (i = 2) { Set result = result + c }
        }
        
        /*Write !
        ZWrite list
        Write !*/
    }

    Return result
}

Method Part2() As %Integer
{
    Set result = 0 
    
    While ('..File.AtEnd){
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"") 

        
        Set list = 1
        Set list(list) = line
        Set cont = 1
        While cont {
            Set len = $LENGTH(line," ")
            Set nline = ""
            For i=2:1:len {
                Set a = $PIECE(line," ",i-1)
                Set b = $PIECE(line," ",i)
                Set c = b - a
                Set nline = nline_c_" "
            }
            Set line = $EXTRACT(nline,1,*-1)
            Set list = list + 1
            Set list(list) = line
            If ($TRANSLATE(line," 0") = "") {
                Set cont = 0
            }
        }

        For i=list:-1:2 {
            Set line =list(i)
            Set a = $PIECE(line," ",1)
            Set pline = list(i-1)
            Set b = $PIECE(pline," ",1)
            Set c = (b - a)
            //Write line,*9,a,*9,b,*9,c,*9,!
            Set pline = c_" "_pline
            Set list(i-1) = pline
            If (i = 2) { Set result = result + c }
        }
        
        /*Write !
        ZWrite list
        Write !*/
    }

    Return result
}

}
