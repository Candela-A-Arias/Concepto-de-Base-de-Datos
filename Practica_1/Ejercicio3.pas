
Program Ejercicio3;

Const 
    F =   'ZZZ';

Type 
    Dino =   Record
        nombre:   string[50];
        tipo:   string[50];
    End;

Procedure CargarArchivo(Var archivo: text);

Var 
    d:   Dino;
Begin
    writeln('Ingrese el nombre del dinosaurio (', F, ' para finalizar):');
    readln(d.nombre);
    writeln('Ingrese el tipo del dinosaurio:');
    readln(d.tipo);
    While d.nombre <> F Do
        Begin
            write(archivo, d.nombre, ' | ');
            writeln(archivo, d.tipo);
            writeln('Ingrese el nombre');
            readln(d.nombre);
            If d.nombre <> F Then
                Begin
                    writeln('Ingrese el tipo del dinosaurio:');
                    readln(d.tipo);
                End;
        End;
End;



Var 
    archivo:   text;
    nombre:   string;
    dinosaurio :   Dino;
Begin
    writeln('Ingrese el nombre del archivo:');
    readln(nombre);         {
    assign(archivo, nombre);
    rewrite(archivo);
    CargarArchivo(archivo);
    close(archivo);
                             }
    //extra
    reset(archivo);
    writeln('Nombre del dinosaurios |      Tipo   ');
    While Not eof(archivo) Do
        Begin
            readln(archivo, dinosaurio.nombre, dinosaurio.tipo);
            writeln(dinosaurio.nombre, ' | ', dinosaurio.tipo);
        End;
    close(archivo);
    readln();
End.
