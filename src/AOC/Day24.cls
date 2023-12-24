Class AOC.Day24 Extends AOC.Base
{

Method Part1(min, max) As %Integer
{
        Set result = 0

        While ('..File.AtEnd){
            Set line = $TRANSLATE(..File.ReadLine(),$CHAR(13),"")
            Set line = $TRANSLATE(line," ","")
            Set coord = $PIECE(line,"@",1)
            Set x = $PIECE(coord,",",1)
            Set y = $PIECE(coord,",",2)
            Set z = $PIECE(coord,",",3)
            Set velocity = $PIECE(line,"@",2)
            Set vx = $PIECE(velocity,",",1)
            Set vy = $PIECE(velocity,",",2)
            Set vz = $PIECE(velocity,",",3)

            Set x2 = x + vx
            Set y2 = y + vy
            Set z2 = z + vz

            /*
                y = ax + b
                a = (y2-y1)/(x2-x1)
                b = (a*x1) + y1
            */
            Set a = (y2 - y)/(x2 - x)
            Set b = y - (a * x)
            
            Set storms = $GET(storms) + 1
            Set storms(storms) = $LISTBUILD(a,b,vx,vy,x,y,line)
        }

        For i=1:1:storms {
            For j=1:1:storms {
                If (i '= j) {
                    If ('$DATA(fnd(i,j)) && '$DATA(fnd(j,i))) {
                        Set fnd(i,j) = ""
                        Set l1 = storms(i)
                        Set l2 = storms(j)

                        Set a1 = $LIST(l1,1)
                        Set a2 = $LIST(l2,1)
                        Set b1 = $LIST(l1,2)
                        Set b2 = $LIST(l2,2)
                        Set vx1 = $LIST(l1,3)
                        Set vx2 = $LIST(l2,3)
                        Set vy1 = $LIST(l1,4)
                        Set vy2 = $LIST(l2,4)
                        Set x1 = $LIST(l1,5)
                        Set x2 = $LIST(l2,5)
                        Set y1 = $LIST(l1,6)
                        Set y2 = $LIST(l2,6)

                        If (a1 '= a2) {
                            Set x = (b2 - b1) / (a1 - a2)
                            Set y = (a1 * x) + b1
                            Set f1 = 0
                            Set f2 = 0
                            
                            If ((vx1 > 0) && (x > x1)) { 
                                If ((vy1 > 0) && (y > y1)) { Set f1 = 1}
                                ElseIf ((vy1 < 0) && (y < y1)) { Set f1 = 1 }
                            } ElseIf ((vx1 < 0) && (x < x1)) {
                                If ((vy1 > 0) && (y > y1)) { Set f1 = 1}
                                ElseIf ((vy1 < 0) && (y < y1)) { Set f1 = 1 }
                            }

                            If ((vx2 > 0) && (x > x2)) { 
                                If ((vy2 > 0) && (y > y2)) { Set f2 = 1}
                                ElseIf ((vy2 < 0) && (y < y2)) { Set f2 = 1 }
                            } ElseIf ((vx2 < 0) && (x < x2)) {
                                If ((vy2 > 0) && (y > y2)) { Set f2 = 1}
                                ElseIf ((vy2 < 0) && (y < y2)) { Set f2 = 1 }
                            }

                            Set future = (f1 & f2)

                            Write $LIST(l1,7),"|",*9,a1,*9,b1,!
                            Write $LIST(l2,7),"|",*9,a2,*9,b2,!
                            Write x,*9,y,*9,future,!
                            
                            If (future && (x >= min) && (y >= min) && (x <= max) && (y <= max)) {
                                Set result = result + 1
                            }
                        }
                    }
                }
            }
        }

        Return result
}

}
