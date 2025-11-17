
* Encoding: UTF-8.

*Directorio actual.
cd 'E:\CURSOS-CONGRESOS\CURSO_ANALISIS_DE_DATOS\SLIDES\CLASE_01\data'.

* Mostrar el directorio. solo valores de sistema.
SHOW DIRECTORY.

* Muestra las opciones que pueden cambiarse a través de la sintaxis, 
  mediante el comando SET. Para ver todas las opciones actuales.
SHOW ALL.

**** PARA MOSTRAR LA LICENCIA .
SHOW LICENCE.

* AUMENTA LA MEMORIA EN 25500 KILOBYTES.
SET WORKSPACE 25500.

* Cambiar el formato por defecto del formato de 
  variable numérica cambiar el formato por defecto
  Ejemplo F8.2 (punto flotante de ocho caracteres
   y dos decimales).
SET FORMAT F8.2.

* El tamaño de página por defecto en SPSS 
  tiene una longitud de 59 líneas y una anchura de 
  80 caracteres.
SHOW LENGTH WIDTH.
SET WIDTH 255.
 
* ECHO de codigo en el visor de resultados.
SHOW PRINTBACK.
SET PRINTBACK ON.



** SUB - PROGRAMAS EN PYTHON.
BEGIN PROGRAM.
import os
print(os.getcwd())
mensaje  = "Por aca todo bien!!"
print(mensaje)
print(mensaje.upper())
END PROGRAM.


* Version de python.
BEGIN PROGRAM.
import sys
print(sys.version)
END PROGRAM.

*#############################################.
* EJERCICIO NRO 1.
* LEER EL FICHERO EXCEL VINOS.XLSX Y GUARDARLO EN FORMATO SAV.

NEW FILE.
DATASET CLOSE ALL.
OUTPUT CLOSE *.


* Lectura de datos de Excel.
GET DATA
/TYPE = XLSX
/FILE = "vinos.xlsx"
/SHEET = name "data"
/CELLRANGE = RANGE "A1:F28"
/READNAMES = ON.

*Guardado en formato SPSS.
SAVE OUTFILE='vinos.sav' 
  /COMPRESSED.


*#############################################.
* EJERCICIO NRO 2.
*ABRIR EL FICHERO DEMO.SAV  GUARDARLO EN FORMATO CSV.

NEW FILE.
DATASET CLOSE ALL.
OUTPUT CLOSE *.


*Abrir base de datos. 
GET FILE = 'demo.sav'.

*Guardado a Csv.
SAVE TRANSLATE
/OUTFILE = "Demo.csv"
/TYPE = csv
/REPLACE
/FIELDNAMES.




*#############################################.
* EJERCICIO NRO 3.
*LEER LOS DATOS SIGUIENTES 
CON NOMBRES DE VARIABLES V1, V2 RESPECTIVAMENTE.
*1 2
2 4
5 6
7 8
9 10
7 5
9 1
8 3
9 11
8 13
3 12.
*SE REQUIERE LO SIGUIENTE:
A) CALCULAR UNA NUEVA VARIABLE LLAMADA V3 QUE ES EL RESULTADO REDONDEADO 
A CERO DECIMALES EL INCREMENTO  DEL 5% DE LA VARIABLE 2 Y SUMAR 5 
B) ASIGNAR UN NOMBRE LLAMADO DATA AL CONJUNTO DE DATOS
C) RECODIFICAR  LA VARIABLE 1, DE MANERA QUE EL 1 AL 5 ESTE RECODIFICADO CON 
EL VALOR 1 Y DEL 6 AL 10 CON EL VALOR 2
D) REALIZAR UNA TABLA DE FRECUENCIA DE LA VARIABLE V1 V2 Y V3 CALCULANDO 
LA MEDIA LA DESVIACION TIPICA EL MINIMO Y EL MÁXIMO
E) RENOMBRAR LA VARIABLE 3 CON VAR3_EDE_3
F) GUARDAR EL CONJUNTO DE DATOS CON EL NOMBRE "Ejercicio nro 3"
.

NEW FILE.
DATASET CLOSE ALL.
OUTPUT CLOSE *.

* lectura de datos en programa.
DATA LIST FREE /var1 var2.
BEGIN DATA
1 2
2 4
5 6
7 8
9 10
7 5
9 1
8 3
9 11
8 13
3 12
END DATA.



*A).
COMPUTE var3 = RND( 1.05*var2 + 5).
EXECUTE.

*B).
DATASET NAME DATA.

*C).
RECODE VAR1 (1 thru 5 =1) (6 thru 10 =2).
EXECUTE.


*D).
FREQUENCIES
 /VARIABLES = VAR1 VAR2 VAR3
 /STATISTICS= MEAN STDDEV MIN MAX.

*E).

RENAME VARIABLES 
    (var3 = var3_ede_3).

*F).
*Guardado en formato SPSS.
SAVE OUTFILE='Ejercicio nro 3.sav' 
  /COMPRESSED.


*#############################################.
* EJERCICIO NRO 4.
*LEER EL SIGUENTE CONJUNTO DE DATOS .
*1 2 1
2 4 1
5 6 2
7 8 2
9 10 2.

*DONDE VAR1 Y VAR2 SON NUMERICOS Y LA VARIABLE 3 ES CATEGORICA CON CON LAS SIGUIENTES DESCRIPCIONES

*NOMBRE DE VARIBLE      |               ETIQUETA                            |     ETIQUETA DE VALOR 
VAR1                                 |        MAGNITUD 1                                |        NINGUNA
VAR2                                 |        MAGNITUD 2                                |        NINGUNA
VAR3                                 |        SEXO                                           |       H o 1:  "Hombre" ; M o 2: "Mujer".  

*SE PIDE LO SIGUIENTE.

*A) COLOCAR LAS DISTINTAS CARACTERISTICAS  DE NOMBRE Y ETIQUETA PARA LAS VARIABLES DEL VAR1 A VAR3 Y LEER DESDE EL CONJUNTO DE DATOS A VAR3 COMO CADENA
 DE TAMAÑO 2 CON ETIQUETAS DE VALOR.
*B) RENOMBRAR AL CONJUNTO DE DATOS COMO DATA_CONJ.
*C) CONVERTIR VAR1 A CADENA DE TAMAÑO 1.
*D) CONVERTIR VAR3 A NUMERICO CON DOS DECIMALES, EXPLIQUE EL RESULTADO.
*E) GUARDAR EL CONJUNTO DE DATOS CON EL NOMBRE "Ejercicio nro 4".
.


*A).

NEW FILE.
DATASET CLOSE ALL.
OUTPUT CLOSE *.

DATA LIST LIST (" ") 
 /VAR1 (f4) VAR2 (F4) VAR3 (A2).
BEGIN DATA
1 2 1
2 4 1
5 6 2
7 8 2
9 10 2
END DATA.

*B).
DATASET NAME DATA_CONJ.

VARIABLE LABELS 
VAR1 'MAGNITUD 1'
VAR2 'MAGNITUD 2'
VAR3 'SEXO'.

RECODE VAR3 ('1' ='H') ('2' ='M').
EXECUTE.

VALUE LABELS VAR3
'H' 'Hombre'
'M' 'Mujer'.

*C).
*Numerico a string.
ALTER TYPE VAR1 (A1).
*D).
* String a numerico.
ALTER TYPE var3 (F1.2).

*E).
*Guardado en formato SPSS.
SAVE OUTFILE='Ejercicio nro 4.sav' 
  /COMPRESSED.
