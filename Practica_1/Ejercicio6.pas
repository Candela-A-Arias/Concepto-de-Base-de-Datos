
Program Ejercicio6;

Type 
    Libro =   Record
        ISBN:   int64;
        titulo:   string;
        genero:   string;
        editorial:   string;
        anio:   integer;
    End;

    CopiaLibrosBin =   File Of Libro;


Procedure Leer(Var libro: Libro);
Begin
    writeln('Ingrese el ISBN del libro (13 digitos):');
    read(libro.ISBN);
    readln;
    writeln('Ingrese el titulo del libro:');
    readln(libro.titulo);
    writeln('Ingrese el a¤o de publicaci¢n del libro:');
    read(libro.anio);
    readln;
    writeln('Ingrese la editorial del libro:');
    readln(libro.editorial);
    writeln('Ingrese el g‚nero del libro:');
    readln(libro.genero);
End;


Procedure Agregar(Var libro: Libro; Var ArchivoLibros: text);
Begin
    writeln('Agregar libro al archivo...');
    writeln(libro.ISBN, ' ', libro.titulo, ' ', libro.genero, ' ', libro.editorial, ' ', libro.anio);
    writeln(ArchivoLibros, libro.ISBN, ' ', libro.titulo);
    writeln(ArchivoLibros, libro.genero, ' ', libro.editorial);
    writeln(ArchivoLibros, libro.anio);
End;

Procedure Mostrar(Var ArchivoLibros: text);

Var 
    li:   Libro;
Begin
    While Not eof(ArchivoLibros) Do
        Begin
            writeln('-----------------------------');

            readln(ArchivoLibros, li.isbn, li.titulo);
            writeln('ISBN: ', li.ISBN, ' | Titulo: ', li.titulo);
            readln(ArchivoLibros, li.anio, li.editorial);
            writeln('A¤o: ', li.anio, ' | Editorial: ', li.editorial);
            readln(ArchivoLibros, li.genero);
            writeln('Genero: ', li.genero);
        End;
    writeln('-----------------------------');
End;

Procedure Cargar(Var ArchivoLibros: text; Var ArchivoLibrosBin: CopiaLibrosBin);

Var 
    li:   Libro;
Begin
    While Not eof(ArchivoLibros) Do
        Begin
            readln(ArchivoLibros, li.isbn, li.titulo);
            readln(ArchivoLibros, li.anio, li.editorial);
            readln(ArchivoLibros, li.genero);
            write(ArchivoLibrosBin, li);
        End;
End;

Procedure imprimirBin(Var ArchivoLibrosBin: CopiaLibrosBin);

Var 
    li:   Libro;
Begin
    reset(ArchivoLibrosBin);
    While Not eof(ArchivoLibrosBin) Do
        Begin
            read(ArchivoLibrosBin, li);
            writeln('ISBN: ', li.ISBN, ' | Titulo: ', li.titulo);
            writeln('A¤o: ', li.anio, ' | Editorial: ', li.editorial);
            writeln('Genero: ', li.genero);
            writeln('-----------------------------');
        End;
End;

Procedure Carga(Var ArchivoLibrosBin: CopiaLibrosBin);

Var 
    li:   Libro;
Begin
    reset(ArchivoLibrosBin);
    writeln('Ingrese los datos del libro a agregar:');
    Leer(li);
    Seek(ArchivoLibrosBin, FileSize(ArchivoLibrosBin));
    write(ArchivoLibrosBin, li);
    writeln('Libro agregado exitosamente.');

End;

Procedure Modificar(Var ArchivoLibrosBin: CopiaLibrosBin);

Var 
    li:   Libro;
    ISBN:   int64;
Begin
    reset(ArchivoLibrosBin);
    writeln('Ingrese el ISBN del libro a modificar:');
    readln(ISBN);

    While (Not eof(ArchivoLibrosBin)) Do
        Begin
            read(ArchivoLibrosBin, li);
            If (li.ISBN = ISBN) Then
                Begin
                    writeln('Ingrese los datos del libro a modificar');
                    Leer(li);
                    Seek(ArchivoLibrosBin, FilePos(ArchivoLibrosBin) - 1);
                    write(ArchivoLibrosBin, li);
                    writeln('Libro modificado exitosamente.');

                    break;
                End;
        End;
    If (eof(ArchivoLibrosBin)) Then
        writeln('Libro no encontrado.');
End;


Var 
    li:   Libro;
    nombre:   string;
    ArchivoLibros:   text;
    ArchivoLibrosBin:   CopiaLibrosBin;
    i :   integer;
Begin
    writeln('Ingrese el nombre del archivo:');
    readln(nombre);
    Assign(ArchivoLibros, nombre);
   { rewrite(ArchivoLibros);
    Leer(li);
    Agregar(li, ArchivoLibros);
writeln('Archivo creado exitosamente.');
Mostrar(ArchivoLibros);

close(ArchivoLibros);

    }
    reset(ArchivoLibros);

    writeln('Ingrese el nombre del archivo binario:');
    readln(nombre);
    Assign(ArchivoLibrosBin, nombre);{
    rewrite(ArchivoLibrosBin);
    Cargar(ArchivoLibros, ArchivoLibrosBin);
    writeln('Archivo binario creado exitosamente.');
    imprimirBin(ArchivoLibrosBin);
    close(ArchivoLibrosBin);}
    imprimirBin(ArchivoLibrosBin);

    writeln('Ingrese 1 para agregar un libro, 2 para modificar un libro:');
    readln(i);
    Case i Of 
        1:
             Begin
                 writeln('Agregar Libro');
                 Carga(ArchivoLibrosBin);
                 imprimirBin(ArchivoLibrosBin);
             End;
        2:
             Begin
                 writeln('Modificar Libro');
                 Modificar(ArchivoLibrosBin);
                 imprimirBin(ArchivoLibrosBin);
             End;
        Else
            writeln('Opci¢n no v lida');
    End;
    close(ArchivoLibros);
    close(ArchivoLibrosBin);
End.
