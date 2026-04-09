
Program Ejercicio7;

Type
    alumnos =   Record
        dni:   integer;
        legajo:   integer;
        nombre:   string[20];
        apellido:   string[20];
        direccion:   string[50];
        anioActual:   integer;
        fechaNacimiento:   longInt;
    End;
Procedure agregarDatos(Var ArchivoLibros: text);
Begin
    writeln(ArchivoLibros, 'DNI | Legajo | Nombre | Apellido | dirección | Año Actual de carrera | Fecha de nacimiento');
            writeln('Agregar Alumno al archivo...');
            writeln(ArchivoLibros, 1, ' | ', 1234, ' | ', 'Patroclo', ' | ', asd, ' | ', walle, ' | ', 2, ' | ', 78465321);
            writeln(ArchivoLibros, 2, ' | ', 4583, ' | ', 'Paladín', ' | ', dsf, ' | ', poo, ' | ', 5, ' | ', 64535456);
            writeln(ArchivoLibros, 3, ' | ', 8745, ' | ', 'Asesino', ' | ', gds, ' | ', zoo, ' | ', 2, ' | ', 4165432);
            writeln(ArchivoLibros, 4, ' | ', 4535, ' | ', 'Rojo', ' | ', sdxf, ' | ', Moria, ' | ', 4, ' | ', 4865218);
            writeln(ArchivoLibros, 5, ' | ', 4562, ' | ', 'Bardo', ' | ', sada, ' | ', loo, ' | ', 3, ' | ', 8475321);
            writeln(ArchivoLibros, 6, ' | ', 5435, ' | ', 'Polaco', ' | ', dgffd, ' | ', aoo, ' | ', 2, ' | ', 8465321);
            writeln(ArchivoLibros, 7, ' | ', 1566, ' | ', 'Monje', ' | ', dfsa, ' | ', see, ' | ', 5, ' | ', 7846531);
            writeln(ArchivoLibros, 8, ' | ', 1235, ' | ', 'Escudero', ' | ', sfdfg, ' | ', leee, ' | ', 0, ' | ', 7864532);
            writeln(ArchivoLibros, 9, ' | ', 8974, ' | ', 'Zamael', ' | ', dfdsgs, ' | ', meee, ' | ', 1, ' | ', 7864535);
            writeln(ArchivoLibros, 10, ' | ', 6544, ' | ', 'Kel´thuzan', ' | ', sfds, ' | ', oppp, ' | ', 2, ' | ', 87645215);
            writeln(ArchivoLibros, 11, ' | ', 5986, ' | ', 'Rogelio', ' | ', Negro, ' | ', koo, ' | ', 1, ' | ', 2154687);
End;
Procedure mostrarDatos(Var arch: text);

Var
    alu:   alumnos;
    basura:   string;
    relleno:   char;
Begin
    reset(arch);
    readln(arch, basura, basura , basura, basura , basura, basura , basura, basura , basura, basura , basura, basura , basura);
    While Not eof(arch) Do
        Begin
            readln(arch, alu.dni, relleno, alu.legajo, relleno , alu.nombre, relleno , alu.apellido, relleno , alu.direccion, relleno , alu.anioActual, relleno , alu.fechaNacimiento);
            writeln('Imprime dni: ', alu.dni, 'legajo: ', alu.legajo);
            //'Nombre del cargado: ', alu.nombre, ' Apellido: ', alu.apellido, ' con DNI: ', alu.dni, ' y legajo: ', alu.legajo, ' nacido el: ', alu.fechaNacimiento, ' y con direccion: ', alu.direccion, ' en el año: ', alu.anioActual,'.');
        End;

End;
Var
    arch:   ArchivoB;
    archivo:   text;
    nombreArchivo:   string;
Begin
    assign(archivo, 'alumnos.txt');
    rewrite(archivo);
    agregarDatos(archivo);
    close(archivo);
    mostrarDatos(archivo);
    close(archivo);
end.

