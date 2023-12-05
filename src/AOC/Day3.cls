Class AOC.Day3 Extends AOC.Base
{

Method Part1() As %Integer
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
                    Set nums = $GET(nums) + 1
                    Set nums(nums) = num
                    Set nums(nums,"x") = $LISTBUILD(i,y)
                    Set num = ""
                }
                Set p = c
            }
            If num'="" {
                Set nums = $GET(nums) + 1
                Set nums(nums) = num
                Set nums(nums,"x")=$LISTBUILD(i,y)
            }
            Set y = y + 1
        }
        ZWrite nums
        Set id = $ORDER(nums(""),1,value)
        While id'="" {
            Set len = $LENGTH(value)
            Set fnd = 0
            Set coord = nums(id,"x")
            Set myx =$LIST(coord,1)
            Set myy = $LIST(coord,2)
            Set fromx = myx-len-1
            Set tox = myx
            Set fromy = myy-1
            Set toy = myy+1
            For y=fromy:1:toy {
                For x=fromx:1:tox{
                    If ($DATA(map(y,x))) {
                        If ((y=myy) && (x'=fromx) && (x'=tox)) {}
                        Else {
                            If num=360 { Write num,*9,y,*9,x,*9,map(y,x),! }
                            If ((map(y,x)'=".") && ('(map(y,x)?1N))) { Set fnd = 1 }
                        }
                    }
                }
            }
            If (fnd=1) { 
                Set result = result + value 
                Write "***",value,!
            }
            ZWrite map(446)
            Set id = $ORDER(nums(id),1,value)
        }
        Return result
}

}
