
Program Ejercicio4;

Type 
    ArchivoVotaciones =   file Of integer;

Procedure CopyPaste(Var ArchivoVtoaciones: ArchivoVotaciones; Var Archivo: text);

Var 
    voto, i:   integer;
Begin
    i := 1;
    writeln('Datos de las votaciones en las provincias:');
    While Not eof(ArchivoVtoaciones) Do
        Begin
            read(ArchivoVtoaciones, voto);
            writeln(Archivo, 'provincia ' , i, ': ' , voto);
            i := i + 1;
        End;
End;

Procedure MuestraArchivo(Var Archivo: text);

Var 
    linea:   string;
Begin
    writeln('Contenido del archivo de votaciones:');
    While Not eof(Archivo) Do
        Begin
            readln(Archivo, linea);
            writeln(linea);
        End;

End;



Var 
    archivoVtoaciones:   ArchivoVotaciones;
    archivo:   text;
    nombreArchivo:   string;
Begin
    nombreArchivo := 'votaciones.dat';
    assign(archivoVtoaciones, nombreArchivo);
    reset(archivoVtoaciones);
    nombreArchivo := 'votaciones.txt';
    assign(archivo, nombreArchivo);
    rewrite(archivo);
    CopyPaste(archivoVtoaciones, archivo);
    reset(archivo);
    MuestraArchivo(archivo);
    close(archivoVtoaciones);
    close(archivo);
End.
