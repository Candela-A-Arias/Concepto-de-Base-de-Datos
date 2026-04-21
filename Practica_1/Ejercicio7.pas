
Program Ejercicio7;

Type 
    alumnos =   Record
        dni:   integer;
        legajo:   integer;
        nombre:   string[10];
        apellido:   string[10];
        direccion:   string[10];
        anioActual:   integer;
        fechaNacimiento:   longInt;
    End;

    ArchivoB =   file Of alumnos;

Procedure Leer(Var alu: alumnos);
Begin
    writeln('Ingrese el DNI del alumno:');
    readln(alu.dni);
    writeln('Ingrese el nombre del alumno:');
    readln(alu.nombre);
    writeln('Ingrese el legajo del alumno:');
    readln(alu.legajo);
    writeln('Ingrese el apellido del alumno:');
    readln(alu.apellido);
    writeln('Ingrese el a¤o actual:');
    readln(alu.anioActual);
    writeln('Ingrese la direcci¢n del alumno:');
    readln(alu.direccion);
    writeln('Ingrese la fecha de nacimiento del alumno:');
    readln(alu.fechaNacimiento);
End;


Procedure agregarDatos(Var ArchivoLibros: text);

Var 
    i :   integer;
    alu:   alumnos;
Begin
    i := 1;
    writeln(ArchivoLibros, 'DNI |Nombre | Legajo | Apellido | A¤o Actual de carrera | direcci¢n | Fecha de nacimiento');
    While i <= 11 Do
        Begin
            Leer(alu);
            writeln('Agregar Alumno al archivo...');
            writeln(ArchivoLibros, alu.dni, ' | ', alu.nombre, ' | ', alu.legajo, ' | ', alu.apellido, ' | ', alu.anioActual, ' | ', alu.direccion, ' | ', alu.fechaNacimiento);
            i := i + 1;
        End;
End;



Procedure cargardatos(Var archivo: text; Var arch: ArchivoB);

Var 
    alumno:   alumnos;
    basura:   string;
Begin
    reset(archivo);
    If Not eof(archivo) Then
        writeln('Cargando datos del archivo de texto al archivo binario...');
    readln(archivo, basura, basura , basura, basura , basura, basura , basura, basura , basura, basura , basura, basura , basura);
    While Not eof(archivo) Do
        Begin
            read(archivo, alumno.dni);
            read(archivo, alumno.nombre);
            read(archivo, alumno.legajo);
            read(archivo, alumno.apellido);
            read(archivo, alumno.anioActual);
            read(archivo, alumno.direccion);
            readln(archivo, alumno.fechaNacimiento);

            write(arch, alumno);
            writeln('Nombre del cargado: ', alumno.nombre, ' Apellido: ', alumno.apellido, ' con DNI: ', alumno.dni, ' y legajo: ', alumno.legajo, ' nacido el: ', alumno.fechaNacimiento, ' y con direccion: ', alumno.direccion, ' en el a¤o: ', alumno.anioActual,'.');
        End;
End;

Procedure mostrarDatos(Var arch: text);

Var 
    alu:   alumnos;
    basura:   string;
Begin
    reset(arch);
    readln(arch, basura);
    writeln(basura);
    While Not eof(arch) Do
        Begin
            read(arch, alu.dni);
            readln(arch, alu.nombre);
            read(arch, alu.legajo);
            read(arch, alu.apellido);
            read(arch, alu.anioActual);{
            read(arch, alu.direccion);
            readln(arch, alu.fechaNacimiento);}
            writeln(alu.dni, ' | ', alu.nombre, ' | ', alu.legajo, ' | ', alu.apellido, ' | ', alu.anioActual, ' | ', alu.direccion, ' | ', alu.fechaNacimiento);
        End;

End;

Var 
    arch:   ArchivoB;
    archivo:   text;
    nombreArchivo:   string;
Begin
    assign(archivo, 'alumnos.txt');

    reset(archivo);

    {rewrite(archivo);
    agregarDatos(archivo);
    close(archivo);}
    mostrarDatos(archivo);{
    writeln('Ingrese el nombre del archivo binario a crear:');
    readln(nombreArchivo);
    assign(arch, nombreArchivo);
    rewrite(arch);
    //Creaci¢n del archivo binario
    //cargardatos(archivo, arch);
    close(arch);


}
    close(archivo);
End.
