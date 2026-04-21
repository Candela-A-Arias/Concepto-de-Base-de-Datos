
Program Ejercicio1;

Type 

    fecha =   Record
        dia:   1..31;
        mes:   1..12;
        anio:   1995..2050;
    End;

    Infdetalle =   Record
        cod:   integer;  {orden de los archivos}
        fechaLicencia:   fecha;
        cantDias:   integer;
    End;

    empleado =   Record
        cod:   integer; {orden de los archivos}
        nombre:   string[20];
        apellido:   string[20];
        fechaCumpl:   fecha;
        dir:   string[20];
        cantHijos:   integer;
        telefono:   integer;
        Diasvacaciones:   integer;
    End;

    detalle =   file Of Infdetalle;
    maestro =   file Of empleado;

Procedure actualizacionMaestro(Var filedet: detalle; Var filemae: maestro, Var NoSePudoActualizar: Text);

Var 
    nuevaInf:   Infdetalle;
    empl:   empleado;
Begin
    While (Not EOF(filedet)) And (Not EOF(filemae)) Do {No se deber¡a chequear si el detalle tiene fuera de los registros de maestro, se asume que el detalle es correcto?}
        Begin
            read(filedet, nuevaInf);
            read(filemae, empl);
            While (empl.cod <> nuevaInf.cod) And (Not EOF(filemae)) Do
                Begin
                    read(filemae, empl);
                End;
            If (empl.cod = nuevaInf.cod) Then
                Begin
                {Se encontr¢ el registro del maestro que corresponde al detalle}
                    If (nuevaInf.cantDias <= empl.Diasvacaciones) Then
                        Begin
                            empl.Diasvacaciones := empl.Diasvacaciones - nuevaInf.cantDias; {Actualiza la cant. de vacaciones restantes en el a¤o}
                        End
                    Else
                        Begin
                            writeln(NoSePudoActualizar, 'No se pudo actualizar el registro del empleado con c¢digo: ', empl.cod, sLineBreak,' nombre: ', empl.nombre, ', apellido: ', empl.apellido, ' con pedido de: ', nuevaInf.cantDias, ' d¡as y disponibilidad de: ', empl.Diasvacaciones, ' d¡as.');
                        End;
                End;
        End;
End;



Var 
    filedet:   detalle;
    filemae:   maestro;
    NoSePudoActualizar:   Text;

Begin
    assign(filedet, 'detalle');
    assign(filemae, 'maestro');
    rewrite(filemae);
    // CargarEmpleados(filemae);
    rewrite(filedet);
    // CargarDetalle(filedet);
    close(filemae);
    reset(filedet);
    reset(filemae);
    assign(NoSePudoActualizar, 'falloActualizacion.txt');
    rewrite(NoSePudoActualizar);
    actualizacionMaestro(filedet, filemae, NoSePudoActualizar);
    close(filedet);
    close(filemae);

End.
