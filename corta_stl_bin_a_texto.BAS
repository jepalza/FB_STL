'compilar como Windows console (FB Console) para ver la salida en la ventana DOS
Var nombrestl="ejemplo.STL"

Var bytes="    "
Var bytenum=0.0
Var bytenumi=0
Var bytenums=""


Var gbytes=Space(50)

dim maxbloque As LongInt=10000000 ' tamaño de los bloques que queremos generar en triangulos
                         ' sabiendo el total de triangulos, los dividimos en los bloques deseados
Dim reg As LongInt=80
   reg=reg+4+1

Var g=0
Var f=0
Dim m(12) As String
dim numtriang As long=0
Var nn=0
dim bloques As Long=0
Var hhh=0
Var erro=0

Dim lonfil As LongInt
Declare Sub abreficherosalida(numerofichero As Integer)

Open nombrestl For Binary Access Read As 1
lonfil=Lof(1)

abreficherosalida(nn)

   	Get #1,reg-4,bytes
	   numtriang=Cvi(bytes)
      Print "Total de triangulos a tratar:";numtriang
      
While Not Eof(1)

   	Get #1,reg,gbytes
   	reg=reg+50 ' la longitud del bloque gbytes
   	
   	For f=1 To 48 Step 4
	    bytes=Mid(gbytes,f,4)
	    bytenum=Cvs(bytes)
	    bytenumi=(Int(bytenum*1000))
	    bytenums=LTrim$(RTrim$(Str$(bytenumi)))
	    bytenums=left(bytenums,len(bytenums)-3)+"."+right(bytenums,3)
	    If Left(bytenums,1)="." Then bytenums="0"+bytenums
	    If Left(bytenums,2)="-." Then bytenums="-0"+Mid(bytenums,2)
	    If bytenums="-2147483.648" Then erro=1
	    m(g)=bytenums
	    g=g+1
   	Next f
      g=0

      'If g<12 Then GoTo otro
        Print #2,"  facet normal ";m(0);" ";m(1);" ";m(2)
        Print #2,"    outer loop"
        Print #2,"      vertex ";m(3);" ";m(4);" ";m(5)
        Print #2,"      vertex ";m(6);" ";m(7);" ";m(8)
        Print #2,"      vertex ";m(9);" ";m(10);" ";m(11)
        Print #2,"    endloop"
        Print #2,"  endfacet"
        
        'Print "  facet normal ";m(0);" ";m(1);" ";m(2)
        'Print "    outer loop"
        'Print "      vertex ";m(3);" ";m(4);" ";m(5)
        'Print "      vertex ";m(6);" ";m(7);" ";m(8)
        'Print "      vertex ";m(9);" ";m(10);" ";m(11)
        'Print "    endloop"
        'Print "  endfacet"
        'Sleep:cls
        
        
        If m(3)=m(4) And m(3)=m(5) Then erro=1
        
        If erro=1 Then
        	   	For f=1 To 48-4 Step 4
	                bytes=Mid(gbytes,f,4)
	   				 bytenum=Cvs(bytes):print "bytenum:";bytenum
	   				 bytenumi=(Int(bytenum*1000)):Print "bytenumi:";bytenumi
	   				 bytenums=LTrim$(RTrim$(Str$(bytenumi)))
	   				 bytenums=left(bytenums,len(bytenums)-3)+"."+right(bytenums,3)
	  				    If Left(bytenums,1)="." Then bytenums="0"+bytenums
	   				 If Left(bytenums,2)="-." Then bytenums="-0"+Mid(bytenums,2)
        	   	Next f
        	   	Print "------------->";reg-50
        	For f=0 To 11:Print m(f):next:sleep
        EndIf
        
        
        'reg=reg+2
        'g=0
        hhh=hhh+1
        If hhh=50000 Then 
        	 hhh=0:Locate 2,1:Print numtriang;"                  "
        	 Print lonfil,lonfil-reg;"                 "
        EndIf
        numtriang=numtriang-1
        bloques=bloques+1
        If bloques>maxbloque Then
        	  bloques=0
        	  nn=nn+1
           abreficherosalida(nn)
        EndIf
   otro:   
	  
Wend
'Print #2,"endsolid c:\cad\a.stl"
Close 1,2
Print "Fin"
Sleep

Sub abreficherosalida(numerofichero As Integer)
	        Close 2
	        Open "parte"+LTrim$(RTrim$(Str$(numerofichero)))+".STL" For Output As 2
           Print #2,"solid jepalza.stl"
End Sub
