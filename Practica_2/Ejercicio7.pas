
Program Ejercicio7;

Const 
    Total_cajas =   10;

Type 
    venta =   Record
        cod_producto:   integer;
        cantidad:   integer;
    End;

    producto =   Record
        cod_producto:   integer;
        nomComercial:   string[20];
        descripcion:   string[50];
        precio:   real;
        stockAct:   integer;
        stockMin:   integer;
    End;

    det =   file Of venta;
    detVect =   array[1..Total_cajas] Of venta;

    detalle =   array[1..Total_cajas] Of det;
    maestro =   file Of producto;

Procedure CrearMaestro(Var prod: Text; Var m: maestro);

Var 
    p:   producto;
Begin
    While (Not eof(prod)) Do
        Begin
            readln(prod, p.cod_producto, p.precio, p.stockAct, p.stockMin);
            readln(prod, p.nomComercial);
            readln(prod, p.descripcion);
            writeLn(p.cod_producto, ' ', p.nomComercial, ' ', p.descripcion, ' ', p.precio:0:2, ' ', p.stockAct, ' ', p.stockMin);
            write(m, p);
        End;
End;

Procedure Leer(Var det: det; Var res: venta);
Begin
    If (Not eof(det)) Then
        read(det, res)
    Else
        res.cod_producto := 9999;
End;

Procedure minimo(Var d: detalle; Var r: detVect; Var min: venta);

Var 
    posMin, i:   integer;
Begin
    min := r[1];
    posMin := 1;
    For i:= 2 To Total_cajas Do
        Begin
            // Comprobamos si hay un codigo menor al asignado en min.
            If (r[i].cod_producto < min.cod_producto) Then
                Begin
                    min := r[i];
                    posMin := i;
                End;
        End;
    Leer(d[posMin], r[posMin]);
End;



Procedure Actualizar(Var m: maestro; Var d: detalle);

Var 
    // Registro para almacenar los datos del detalle
    detalleVenta:   detVect;
    min:   venta;
    maestro:   producto;
    i:   integer;
    nombre:   string[20];
Begin
    For i:= 1 To Total_cajas Do
        Begin
            writeln('Ingrese el nombre del archivo detalle ', i, ':');
            readln(nombre);
            assign(d[i], 'detalle' + nombre + '.dat');
            reset(d[i]);
            // Leemos el primer registro de cada archivo detalle y lo guardamos en el vector detalleVenta
            If (Not eof(d[i])) Then
                read(d[i], detalleVenta[i])
            Else
                detalleVenta[i].cod_producto := 9999;
            // Valor alto para indicar que se lleg¢ al final del archivo
        End;
    reset(m);
    minimo(d, detalleVenta, min);
    maestro.cod_producto := 9999;
    While (min.cod_producto <> 9999) Do
        Begin
            While (maestro.cod_producto <> min.cod_producto) Do
                read(m, maestro);
            While (maestro.cod_producto = min.cod_producto) Do
                Begin
                    maestro.stockAct := maestro.stockAct - min.cantidad;
                    minimo(d, detalleVenta, min);
                End;
            seek(m, filepos(m) - 1);
            write(m, maestro);
        End;
    close(m);
    For i:= 1 To Total_cajas Do
        close(d[i]);

End;



Var 
    prod:   Text;
    m:   maestro;
    d:   detalle;
    nombre:   string[20];
    opc :   integer;
Begin
    writeln('Ingrese el numero de ejercicio a ejecutar:');
    writeln('1. Crear el archivo maestro a partir del archivo de texto prod.');
    writeln('2. Actualizar el archivo maestro a partir de los archivos detalle.');
    writeln('3. Salir.');
    readln(opc);
    Repeat
        Case opc Of 
            1:
                 Begin
                     nombre := 'productos.txt';
                     assign(prod, nombre);
                     reset(prod);
                     // Se crea el archivo binario maestro a partir del archivo de texto prod
                     assign(m, 'maestro.dat');
                     rewrite(m);
                     CrearMaestro(prod, m);
                     close(prod);

                 End;
            2:
                 Begin
                     Actualizar(m, d);
                 End;
        End;
    Until (opc = 3);
    close(m);
End.
