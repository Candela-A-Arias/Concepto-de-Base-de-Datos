
Program Ejercicio5;

Const 
    F =   'ZZZ';

Type 
    TipoFlores =   Record
        numeroEspecie:   integer;
        NombreCientifico:   string[200];
        alturapromedio:   real;
        nombreComun:   string[100];
        color:   string[100];
        alturaMaximaAlcanzada:   real;
    End;

    ArchivoFlores =   File Of TipoFlores;

Procedure LeerFlor(Var flor: TipoFlores);
Begin
    Write('Ingrese el numero de especie: ');
    ReadLn(flor.numeroEspecie);
    Write('Ingrese la Altura Promedio: ');
    ReadLn(flor.alturapromedio);
    Write('Ingrese el nombre comun: ');
    ReadLn(flor.nombreComun);
    Write('Ingrese el color: ');
    ReadLn(flor.color);
    Write('Ingrese la Altura Maxima alcanzada: ');
    ReadLn(flor.alturaMaximaAlcanzada);
End;

Procedure CargarDatos(Var florMax, florMin: TipoFlores; Var archivo: ArchivoFlores);

Var 
    cant :   integer;
    flor:   TipoFlores;
    max, min :   real;
Begin
    cant := 0;
    max := 0;
    min := 9999;

    Write('Ingrese el nombre cientifico: ');
    ReadLn(flor.NombreCientifico);
    While (flor.nombreCientifico <> F) Do
        Begin
            cant := cant + 1;
            LeerFlor(flor);
            If (flor.alturaMaximaAlcanzada > max) Then
                Begin
                    max := flor.alturaMaximaAlcanzada;
                    florMax := flor;
                End;
            If (flor.alturaMaximaAlcanzada < min) Then
                Begin
                    min := flor.alturaMaximaAlcanzada;
                    florMin := flor;
                End;
            Write(archivo, flor);
            Write('Ingrese el nombre cientifico: ');
            ReadLn(flor.NombreCientifico);
        End;
End;

// Punto C
Procedure ModificarFlor(Var archivo: ArchivoFlores);

Var 
    flor:   TipoFlores;
    nombre:   string[200];
Begin
    Write('Ingrese el nombre cientifico de la flor a modificar: ');
    ReadLn(nombre);
    Reset(archivo);
    While Not Eof(archivo) Do
        Begin
            Read(archivo, flor);
            If flor.NombreCientifico = nombre Then
                Begin
                    Write('Ingrese el nuevo nombre cientifico: ');
                    ReadLn(flor.NombreCientifico);
{Seek posiciona el cabezal de escritura exactamente encima del 
 registro que acabas de leer para que el Write posterior lo sobrescriba con los nuevos datos.}
                    Seek(archivo, FilePos(archivo) - 1);
                    Write(archivo, flor);
                    Break;
                End;
        End;
End;

//Punto D
Procedure AgregarAlFinal(Var archivo: ArchivoFlores);

Var 
    flor:   TipoFlores;
Begin
    reset(archivo);
    // Mover el puntero al final del archivo
    Seek(archivo, FileSize(archivo) - 1);
    Write('Ingrese el nombre cientifico de la nueva flor: ');
    ReadLn(flor.NombreCientifico);
    While (flor.NombreCientifico <> F) Do
        Begin
            LeerFlor(flor);
            // Escribir la nueva flor al final del archivo
            Write(archivo, flor);
            Write('Ingrese el nombre cientifico de la nueva flor: ');
            ReadLn(flor.NombreCientifico);
        End;
End;






Var 
    archivo:   ArchivoFlores;
    max, min:   real;
    cant :   integer;
    florMax, florMin, flor:   TipoFlores;

Begin
    Assign(archivo, 'flores.dat');{
    Rewrite(archivo);
    CargarDatos(florMax, florMin, archivo);
    Close(archivo);}
    // Mostrar el contenido del archivo
    reset(archivo);

    max := 0;
    min := 9999;
    cant := 0;


    readln;
    WriteLn('-----------------------------');
    While Not Eof(archivo) Do
        Begin
            cant := cant + 1;
            Read(archivo, flor);
            WriteLn('Nombre Cientifico: ', flor.NombreCientifico);
            Write('| Numero de Especie: ', flor.numeroEspecie);
            Write('| Altura Promedio: ', flor.alturapromedio:   2:   2);
            Write('| Nombre Comun: ', flor.nombreComun);
            Write('| Color: ', flor.color);
            Write('| Altura Maxima Alcanzada: ', flor.alturaMaximaAlcanzada:   2:   2);
            If (flor.alturaMaximaAlcanzada > max) Then
                Begin
                    max := flor.alturaMaximaAlcanzada;
                    florMax := flor;
                End;
            If (flor.alturaMaximaAlcanzada < min) Then
                Begin
                    min := flor.alturaMaximaAlcanzada;
                    florMin := flor;
                End;
            WriteLn;
            WriteLn('-----------------------------');
        End;
    writeln('Cantidad de flores: ', cant);
    WriteLn('Flor con mayor altura alcanzada: ', florMax.NombreCientifico, ' con una altura de ', florMax.alturaMaximaAlcanzada:   2:   2);
    WriteLn('Flor con menor altura alcanzada: ', florMin.NombreCientifico, ' con una altura de ', florMin.alturaMaximaAlcanzada:   2:   2);
    Close(archivo);
    readln;
End.
