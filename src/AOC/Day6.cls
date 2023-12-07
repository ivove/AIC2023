Class AOC.Day6 Extends AOC.Base
{

Method Part1() As %Integer
{
        Set result = 1 
        //Write !,"1"
        set type = "time"
        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            set values = $PIECE(line,":",2)
            set len = $LENGTH(values," ")
            set num = 1
            for i=1:1:len {
                set x = $PIECE(values," ",i)
                if (x?1.N) {
                    set races(num,type) = x
                    set num = num + 1
                }
            }
            set type = "dist"
        }

        set num = $ORDER(races(""))
        while num '= "" {
            set time = races(num,"time")
            set dist = races(num,"dist")

            set beat = 0
            for t=1:1:time {
                set travel = (time - t) * t
                if num = 2 {
                    write t,*9,(time - t),*9,(time - t) * t,*9,"***",dist,!
                }
                if (travel > dist) {
                    set beat = beat + 1
                }
            } 

            write num,*9,beat,!
            set result = result * beat

            set num = $ORDER(races(num))
        }
        //zw races
        Return result
}

Method Part2() As %Integer
{
        Set result = 0
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set values = $PIECE(line,":",2)
        set time = $TRANSLATE(values," ","")
        
        Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
        set values = $PIECE(line,":",2)
        set dist = $TRANSLATE(values," ","")

        for t=1:1:time {
            set travel = (time - t) * t
            if (travel > dist) {
                set result = result + 1
            }
        }         
        //zw races
        Return result
}

}
