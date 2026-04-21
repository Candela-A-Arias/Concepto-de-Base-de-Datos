
Program Ejercicio2;

Type 

    CD =   Record
        cod:   integer;
        nombre_autor:   string[20];
        nombre_cd:   string[20];
        genero:   string[20];
        ventas:   integer;
    End;

    ArchivoCD =   file Of CD;

Procedure revisarArchivo(Var fileCD: ArchivoCD; Var ArchiCD_texto: Text);

Var 
    cds:   CD;
    cant_genero:   integer;
    cant_Autor:   integer;
    totalDiscos:   integer;
    autor:   string[20];
    genero:   string[20];

Begin
    If Not EOF(fileCD) Then
        Begin
            read(fileCD, cds);
            While Not EOF(fileCD) Do
                Begin
                    autor := cds.nombre_autor;
                    genero := cds.genero;
                    cant_Autor := 0;
                    totalDiscos := 0;

                    writeLn(ArchiCD_texto, 'Autor: ', autor);
                    While (Not EOF(fileCD)) And (cds.nombre_autor = autor) Do
                        Begin
                            genero := cds.genero;
                            writeLn(ArchiCD_texto, '    Genero: ', genero);
                            cant_genero := 0;
                            While (cds.genero = genero) And (Not EOF(fileCD)) Do
                                Begin
                                    writeLn(ArchiCD_texto, 'Nombre del Disco: ', cds.nombre_cd, 'cantidad ventas: ', cds.ventas);
                                    cant_genero := cant_genero + 1;
                                    cant_Autor := cant_Autor + 1;
                                    totalDiscos := totalDiscos + 1;
                                    read(fileCD, cds);
                                End;
                            writeLn(ArchiCD_texto, 'Total Genero:', cant_genero);
                        End;
                    writeLn(ArchiCD_texto, 'Total Autor:', cant_Autor);
                    writeLn(ArchiCD_texto, 'Total Discograf¡a:', totalDiscos);

                End;
        End;
End;

Procedure ResultadoPantalla(Var ArchiCD_texto: Text);

Var 
    linea:   string;
Begin
    While Not eof(ArchiCD_texto) Do
        Begin
            readln(ArchiCD_texto, linea);
            writeln(linea);
        End;
End;

Var 
    fileCD:   ArchivoCD;
    ArchiCD_texto:   Text;

Begin
    assign(fileCD, 'ArchivoCD');
{rewrite(fileCD);
CargarCD(fileCD);
close(fileCD);}
    reset(fileCD);
    assign(ArchiCD_texto, 'ArchivoCD_texto.txt');
    rewrite(ArchiCD_texto);
    revisarArchivo(fileCD, ArchiCD_texto);
    reset(ArchiCD_texto);
    ResultadoPantalla(ArchiCD_texto);
    close(fileCD);
    close(ArchiCD_texto);
End.
