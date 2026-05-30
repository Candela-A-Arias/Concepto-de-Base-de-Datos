
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

    detalle =   array[1..Total_cajas] Of det;
    maestro =   file Of producto;

Var 
    prod:   Text;
    m:   maestro;
    d:   detalle;
    nombre:   string[20];
Begin
End.
