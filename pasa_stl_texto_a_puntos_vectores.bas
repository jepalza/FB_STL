' compilar en fb_console (windows console)
open "ejemplo.stl" for input as 1
open "puntos.txt" for output as 2
open "vectores.txt" for output as 3

' programa que lee un STL ASCII y lo saca en formato XYZ, como --> x,y,z
' y la composicion de los vectores que forman el triangulo, en formato nv,a,b,c (ANULADO EN PRUEBAS)
' donde nv es el numero de vertices, que en un STL es de 3 SIEMPRE (son triangulos)
' segun la forma necesaria por el programa de 3D mio, en el cual, un triangulo tiene tres vertices
' y tres curvas que lo cierran
'
'     a
'    /\
'   /  \
' b/____\c
' 
' con lo cual, los vectores son --> a-c, c-b y b-a y cada vector  ABC es del tipo XYZ

Dim yaobtenidos As Integer ' cuando obtenemos todos los vertices, salimos de la rutina (generalmente, solo 3)
Dim coord As Integer
Dim sa As String
Dim ncoord As Integer ' contador de valores que van saliendo en cada superficie (teoricamente:XYZ y 3 por triang.)
dim sv(10) As String ' aqui guardamos los vertices obtenidos
Dim i As Integer
Dim f As integer

coord=0
yaobtenidos=0
ncoord=0

while not eof(1)
    line input #1,sa
    sa=UCase$(sa)
    
    if instr(sa,"VERTEX") Then
            sa=LTrim$(mid$(sa,instr(sa,"X")+2))+" "
            sv(ncoord)=LEFT$(sa,InStr(sa," ")) ' coord x
            sa=LTrim$(Mid$(sa,InStr(sa," ")))
            ncoord=ncoord+1
            sv(ncoord)=LEFT$(sa,InStr(sa," ")) ' coord y
            sa=LTrim$(Mid$(sa,InStr(sa," ")))
            ncoord=ncoord+1
            sv(ncoord)=LEFT$(sa,InStr(sa," ")) ' coord z
            sa=LTrim$(Mid$(sa,InStr(sa," ")))
            ncoord=ncoord+1
            yaobtenidos=yaobtenidos+1
    end if
    

    
    if yaobtenidos=3 then 
        
        'x1=val(b$(0))
        'y1=val(b$(1))
        'z1=val(b$(2))
        'x2=val(b$(3))
        'y2=val(b$(4))
        'z2=val(b$(5))
        'x3=val(b$(6))
        'y3=val(b$(7))
        'z3=val(b$(8))

        'x1$=str$(x1)
        'y1$=str$(y1)
        'z1$=str$(z1)
        'x2$=str$(x2)
        'y2$=str$(y2)
        'z2$=str$(z2)  
        'x3$=str$(x3)
        'y3$=str$(y3)
        'z3$=str$(z3) 
                 
        ' grabamos los datos formato X,Y,Z
        print #2, sv(0);" , ";sv(1);" , ";sv(2)
        print #2, sv(3);" , ";sv(4);" , ";sv(5)
        print #2, sv(6);" , ";sv(7);" , ";sv(8)
                 
        ' Grabamos los vectores del triangulo del STL
        ' y los tres correspondientes para cerrar un triangulo
        Print #3, str$(coord+0);",";str$(coord+1)
        Print #3, str$(coord+1);",";str$(coord+2)
        Print #3, str$(coord+2);",";str$(coord+0)
        Print #3, ""
        
        Locate 1,1:Print "TRIANGULOS OBTENIDOS:";COORD/3
        
        coord=coord+3
        yaobtenidos=0
        ncoord=0
    end if

wend
close 1,2,3
    