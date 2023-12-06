Class AOC.Day5 Extends AOC.Base
{

Method Part1() As %Integer
{
        Set result = 999999999999999
        Set y = 1
        Set type = ""
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")

            If (y = 1 ){
                Set seeds = $LISTFROMSTRING($PIECE(line,": ",2)," ")
            } Else {
                If (line = "") {
                    If (type = "") { Set type = "s2s" }
                    ElseIf (type = "s2s") { Set type = "s2f" }
                    ElseIf (type = "s2f") { Set type = "f2w" }
                    ElseIf (type = "f2w") { Set type = "w2l" }
                    ElseIf (type = "w2l") { Set type = "l2t" }
                    ElseIf (type = "l2t") { Set type = "t2h" }
                    ElseIf (type = "t2h") { Set type = "h2l" }
                    Do ..TestFile.ReadLine()
                }
                Else {
                    Set source = $PIECE(line," ",2)
                    Set dest = $PIECE(line," ",1)
                    Set len = $PIECE(line," ",3)
                    Set map(type,source) = $LISTBUILD(dest,len)
                }
            }  

            Set y = y + 1
        }

        For i=1:1:$LISTLENGTH(seeds) {
            Set seed = $LIST(seeds,i)
            Set loc = seed
            For type = "s2s","s2f","f2w","w2l","l2t","t2h","h2l" {
                If $DATA(map(type,loc)) {
                    Set loc = $LIST(map(type,loc),1)
                } Else {
                    Set x = $ORDER(map(type,loc),-1,value)
                    If (x '= "") {
                        If ((loc-x) < $LIST(value,2)) {
                            Set loc = $LIST(value,1) + (loc - x)
                        }
                    }
                }
            }
            If (loc < result) { Set result = loc }
        }

        ZWrite map

        Return result
}

Method Part2() As %Integer
{
        Set result = 999999999999999
        Set y = 1
        Set type = ""
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")

            If (y = 1 ){
                Set seeds = $LISTFROMSTRING($PIECE(line,": ",2)," ")
            } Else {
                If (line = "") {
                    If (type = "") { Set type = "s2s" }
                    ElseIf (type = "s2s") { Set type = "s2f" }
                    ElseIf (type = "s2f") { Set type = "f2w" }
                    ElseIf (type = "f2w") { Set type = "w2l" }
                    ElseIf (type = "w2l") { Set type = "l2t" }
                    ElseIf (type = "l2t") { Set type = "t2h" }
                    ElseIf (type = "t2h") { Set type = "h2l" }
                    Do ..File.ReadLine()
                }
                Else {
                    Set source = $PIECE(line," ",2)
                    Set dest = $PIECE(line," ",1)
                    Set len = $PIECE(line," ",3)
                    Set map(type,source) = $LISTBUILD(dest,len)
                }
            }  

            Set y = y + 1
        }

        For i=1:2:$LISTLENGTH(seeds) {
            Set start = $LIST(seeds,i)
            Set end = $LIST(seeds,i+1) - 1
            //Write start,*9,end,!
            For y=0:1:end {
                Set seed = start + y
                //Write start,*9,end,*9,seed,!
                Set loc = seed
                For type = "s2s","s2f","f2w","w2l","l2t","t2h","h2l" {
                    If $DATA(map(type,loc)) {
                        Set loc = $LIST(map(type,loc),1)
                    } Else {
                        Set x = $ORDER(map(type,loc),-1,value)
                        If (x '= "") {
                            If ((loc-x) < $LIST(value,2)) {
                                Set loc = $LIST(value,1) + (loc - x)
                            }
                        }
                    }
                }
                If (loc < result) { Set result = loc }
            }
        }

        //ZWrite map

        Return result
}

}
