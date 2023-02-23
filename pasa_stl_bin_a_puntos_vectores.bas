'compilar como Windows console (FB Console) para ver la salida en la ventana DOS

' para usar el FORMAT y convertir de numero real (decimal) a cadena formateada
#include "string.bi"


Var nombrestl="ejemplo.STL"

Var bytes="    "
Var bytenum=0.0
Var bytenumi=0
Var bytenums=""

Dim Shared As integer STLASCII=0 ' si queremos salida en STL-ASCII o texto normal, para mi gusto

Var vertice=0 ' indice de vertices localizados

Var gbytes=Space(50)

Dim reg As LongInt=80 ' comienzo de los datos, en la dir 80 (desde "0", o sea, la 81)
   reg=reg+4  +1 ' direccion de los 4 bytes que indican el nº de triang. +1 para compensar el tema del basic

var a=0
Var g=0
Var f=0
Dim cad_str(12) As String
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

   	Get #1,reg,gbytes ' se lee un bloque completo de un triangulo (
   	reg=reg+50 ' la longitud del bloque gbytes
   	' desconozco por se leen 50, pero se tratan 48 (12 coordenadas por 4 bytes=48 datos, faltan 2!!!)
   	
   	' saco coordenadas de los bytes leidos
   	For f=1 To 48 Step 4
	    bytes=Mid(gbytes,f,4)
	    bytenum=Cvs(bytes) ' la magia, pasa de binario a decimal
	    ' redondeo para quitar mas alla de la milesima
	    bytenums=Str$(bytenum)
	    ' y ajustes para dejarlo "bonito" en modo texto
	    a=InStr(bytenums,".")
		 If a Then bytenums=Left(bytenums,a+3)
	    cad_str(g)=bytenums
	    g=g+1
   	Next f
      g=0

      'If g<12 Then GoTo otro
      ' si queremos sacar como STL-ASCII
      If STLASCII=1 Then
        Print #2,"  facet normal ";cad_str(0);" ";cad_str(1);" ";cad_str(2)
        Print #2,"    outer loop"
        Print #2,"      vertex ";cad_str(3);" ";cad_str(4);" ";cad_str(5)
        Print #2,"      vertex ";cad_str(6);" ";cad_str(7);" ";cad_str(8)
        Print #2,"      vertex ";cad_str(9);" ";cad_str(10);" ";cad_str(11)
        Print #2,"    endloop"
        Print #2,"  endfacet"
      Else          
        ' grabamos los datos formato X,Y,Z (y la normal, por si acaso)
        print #2, "Normal:";cad_str(0);" , ";cad_str(1);" , ";cad_str(2) ' vector de orientacion
        print #2, cad_str(3);" , ";cad_str(4);" , ";cad_str(5)
        print #2, cad_str(6);" , ";cad_str(7);" , ";cad_str(8)
        print #2, cad_str(9);" , ";cad_str(10);" , ";cad_str(11)
                 
        ' Grabamos los vectores del triangulo del STL, los que hacen el triangulo de punto a punto
        ' y los tres correspondientes para cerrar un triangulo
        ' opcional, solo interesa para dibujos y cosas asi
        ' es tan simple como 0 a 1, 1 a 2, 2 a 0 y cerramos triangulo
        'Print #2, str$(vertice+0);",";str$(vertice+1);",";
        'Print #2, str$(vertice+1);",";str$(vertice+2);",";
        'Print #2, str$(vertice+2);",";str$(vertice+0)
        'Print #3, "" ' un simple hueco
        'vertice+=3
      End If

        hhh=hhh+1
        If hhh=50000 Then 
        	 hhh=0:Locate 2,1:Print numtriang;"                  "
        	 Print lonfil,lonfil-reg;"                 "
        EndIf
        numtriang=numtriang-1
        bloques=bloques+1
	  
Wend
'Print #2,"endsolid c:\cad\a.stl"
Close 1,2
Print "Fin"
Sleep

Sub abreficherosalida(numerofichero As Integer)
	        Close 2
           If STLASCII=1 Then 
           	Open "salida_ASCII.stl" For Output As 2
           	Print #2,"solid jepalza.stl"
           Else 
           	Open "salida_texto.txt" For Output As 2
           EndIf
End Sub
