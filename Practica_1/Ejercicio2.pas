
Program Ejercicio2;

Const 
    F =   0; {Constante para indicar el fin de la entrada de n£meros}

Type 
    {Tipo de archivo binario para almacenar n£meros}
    Archivo =   file Of integer;


{Procedimiento para ingresar n£meros aleatorios en un archivo binario}
Procedure IngresarNumeros(Var fileA: Archivo);

Var 
    num:   array[1..10] Of integer;
    i :   integer;
Begin
    num[1] := 22;
    num[2] := 83;
    num[3] := 400;
    num[4] := 5;
    num[5] := 60;
    num[6] := 78;
    num[7] := 8;
    num[8] := 29;
    num[9] := 190;
    num[10] := 52;
    For i := 1 To 10 Do
        Begin
            write(fileA, num[i]);
        End;
End;

Procedure MaximoyMinimo(Var fileA: Archivo; Var max, min: integer);

Var 
    num, i:   integer;
Begin
    i := 1;
    writeln('cod. de Localidad | cantidad de votos');
    While Not Eof(fileA) Do
        Begin
            read(fileA, num);
            If num > max Then
                max := num;
            If num < min Then
                min := num;
            If i <= 10 Then
                Begin
                    writeln('         ', i, '          |         ', num, '         ');
                    i := i + 1;
                End;
        End;
End;



Var 
    ArchivoVotacion:   Archivo;
    nombreArchivo:   String;
    max, min:   integer;
Begin
    writeln('ingrese el nombre del archivo a leer: ');
    nombreArchivo := 'votacion.dat';
    assign(ArchivoVotacion, nombreArchivo);
    rewrite(ArchivoVotacion);
    IngresarNumeros(ArchivoVotacion);
    close(ArchivoVotacion);
    writeln('ingrese el nombre del archivo a leer: ');
    readln(nombreArchivo);
    assign(ArchivoVotacion, nombreArchivo);
    reset(ArchivoVotacion);
    max := -1; {Inicializamos max con un valor menor al m¡nimo posible}
    min := 9999; {Inicializamos min con un valor mayor al m ximo posible}
    MaximoyMinimo(ArchivoVotacion, max, min);
    writeln('El n£mero m ximo de votos es: ', max);
    writeln('El n£mero m¡nimo de votos es: ', min);
    close(ArchivoVotacion);
End.
