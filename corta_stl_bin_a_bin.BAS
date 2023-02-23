'compilar como Windows console (FB Console) para ver la salida en la ventana DOS
Dim nombrefich As String
nombrefich="ejemplo.stl"


Dim datoint As Integer

' tamaño de los bloques que queremos generar en triangulos
' sabiendo el total de triangulos, los dividimos en los bloques deseados
Dim maxbloque As LongInt 
                         
Dim reg As LongInt=80
reg=reg+4+1
Dim reg2 As LongInt=reg

Var g=0
Var f=0

Dim bytes As String="    "
dim numtriang As long=0
Dim numtriang2 As integer=0
Dim bloques As Long=0
Var hhh=0
Dim mkvalor As String
Dim ff As integer 
Dim cero As uByte=0 

Dim lonfil As LongInt

Declare Sub abreficherosalida(numerofichero As Integer)

Open nombrefich For Binary Access Read As 1
lonfil=Lof(1)

abreficherosalida(nn)

   	Get #1,reg-4,bytes
	   numtriang=Cvi(bytes)
	   Print "tamano de fichero:";lonfil
      Print "Total de triangulos a tratar:";numtriang
      Print "(cada triangulo ocupa 50bytes: 1millon, 50megas de archivo)"
      Print "velocidad:10000 triangulos por segundo"
      Print "tiempo estimado:";numtriang/1000;" segundos"
      Print "Cuantos triangulos quieres en cada fichero? ";
      Input "",ff
      maxbloque=ff
      Cls
      Print "Longitud de archivo (bytes):";lonfil;"  Grupos cada: ";maxbloque;" Triang."
  
While Not Eof(1)

   	For f=1 To 12
   	 Get #1,reg,datoint
   	 reg+=4
	    Put #2,reg2,datoint
	    reg2+=4
   	Next f

        cero=0
        Put #2,reg2+0,cero
        cero=&h80
        Put #2,reg2+1,cero
        reg2+=2
        reg+=2

        hhh=hhh+1
        If hhh=5000 Then 
        	 hhh=0
        	 Locate 2,1
        	 Print "Triangulos hasta acabar:";numtriang;"     "
        	 'Print lonfil-reg;"     "
        EndIf 
        
        numtriang=numtriang-1 ' triangulos totales hasta llegar a cero
        numtriang2=numtriang2+1 ' triangulos que llevamos hechos
        bloques=bloques+1 ' miramos si hemos alcanzado el bloque a separar
        If bloques>maxbloque Then
        	  bloques=0
	        	mkvalor=Mki(numtriang2)
	        	reg2=80+1
	        	Put #2,reg2+0,Asc(Mid(mkvalor,1,1))
	        	Put #2,reg2+1,Asc(Mid(mkvalor,2,1))
	        	Put #2,reg2+2,Asc(Mid(mkvalor,3,1))
	        	Put #2,reg2+3,Asc(Mid(mkvalor,4,1)) 
           abreficherosalida(nn)
           reg2=85
        EndIf 
	  
Wend

Close 1,2
Print "Fin"
Sleep

Sub abreficherosalida(numerofichero As Integer)
	        Close 2
	        Dim f As integer
	        Dim minombre As string
	        Open "parte"+LTrim$(RTrim$(Str$(numerofichero)))+".STL" For Binary Access write As 2
           'Print #2,"solid jepalza.stl"
           minombre="J.EPALZA "+Space(70)+Chr(0)
           For f=1 To 80
           	 Put #2,f,Asc(Mid(minombre,f,1)) 
           Next
End Sub
