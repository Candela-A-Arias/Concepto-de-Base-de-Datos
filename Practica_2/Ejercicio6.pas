
Program Ejercicio6;

Type 

    servicios =   Record
        // primer orden
        codMozo:   integer;
        fecha:   longint;
        monto:   real;
    End;

    nodo =   Record
        fecha:   longint;
        sig:   ^nodo;
    End;

    Lista =   ^nodo;

    servicio =   Record
        //primer orden
        codMozo :   integer;
        fechas:   Lista;
        monto_total:   real;
    End;

    detalle =   file Of servicios;
    maestro =   file Of servicio;

Procedure AgregarOrdenado(Var l: List, dato: longint);
// de menor a mayor, sin repetidos

Var 
    aux, ant, sig:   List;
Begin
    new(aux);
    aux.fecha := dato;
    aux.sig := Nil;
    // si est  vacia
    If (l = Nil) Then
        l := aux
             // si no est  vacia, y el dato es menor al primer elemento
    Else If (l.fecha > dato) Then
             Begin
                 aux.sig := l;
                 l := aux;
             End
    Else
        // si no est  vacia, y el dato es mayor al primer elemento
        Begin
            ant := l;
            sig := l;
            While (sig <> Nil) And (sig.fecha < dato) Do
                Begin
                    ant := sig;
                    sig := sig.sig;
                End;
            If (ant = sig) Then
                l := aux
            Else
                ant.sig := aux;
            aux.sig := sig;
        End;
End;


Procedure CargandoAMaestro(Var d: detalle,Var m: maestro);

Var 
    fechas:   Lista;
    ser:   servicio;
    servs:   servicios;
Begin
    If (eof(d)) Then
        Begin
            writeln('El archivo detalle est  vac¡o');
            exit;
        End
    Else
        Begin
            read(d, servs);
            While (Not eof(d)) Do
                Begin
                    ser.codMozo := servs.codMozo;
                    ser.monto_total := 0;
                    fechas := Nil;
                    //pierdo direccion de la lista
                    //Mientras no se acabe el archivo, y el cod de mozo sea el mismo
                    While ((Not eof(d)) And (ser.codMozo = servs.codMozo)) Do
                        Begin
                            ser.monto_total := ser.monto_total + servs.monto;
                            AgregarOrdenado(fechas, servs.fecha);
                            read(d, servs);
                        End;
                    ser.fechas := fechas;
                    //la direccion de la lista se asigna al campo fechas del registro servicio
                    write(m, ser);
                End;
        End;
End;

Var 
    nombre:   string;
    det:   detalle;
    m:   maestro;
Begin
    writeln('Ingrese el nombre del archivo detalle : ');
    read(nombre);
    assign(det, nombre);
    reset(det);
    writeln('Ingrese el nombre del nuevo archivo maestro : ');
    read(nombre);
    assign(m, nombre);
    rewrite(m);
    CargandoAMaestro(det, m);
    close(m);
    close(det);
End.
