
Program Ejercicio3;

Const 
    cant_detalles =   20;
    //Final del archivo detalle
    valor_alto =   9999;

Type 
    calzadoVendido =   Record
        ///primer orden
        cod:   integer;
        /// segundo orden
        numero:   integer;
        cant:   integer;
    End;

    calzado =   Record
        cod:   integer;
        /// primer orden
        numero:   integer;
        ///segundo orden
        descripcion:   string;
        precioUnitario:   real;
        color:   string;
        cant_stock:   integer;
        minim_stock:   integer;
    End;

    fdetalle =   file Of calzadoVendido;
    maestro =   file Of calzado;
    calzVendid =   text;
    detalle =   array [1..cant_detalles] Of fdetalle;
    resto =   array [1..cant_detalles] Of calzadoVendido;


    // Se guarda en res los valores del archivo del vector detalle, 
    //o el valor alto si se lleg¢ al final del archivo
Procedure Leer(Var det:fdetalle, Var res: resto);
Begin
    If (Not eof(det)) Then
        read(det, res)
    Else
        res.codigo := valor_alto;
End;

// Busco el archivo con el menor c¢digo de calzado vendido, y lo guardo en min, 
//junto con la posici¢n del detalle al que corresponde
Procedure minimo(Var det: detalle, Var res: resto, Var min: fdetalle);

Var 
    posMin:   integer;
Begin
    min := res[1];
    posMin := 1;
    For i:= 2 To cant_detalles Do
        Begin
            // Comprobamos si hay un codigo menor al asignado en min.
            If (res[i].codigo < min.codigo) Then
                Begin
                    min := res[i];
                    posMin := i;
                End
            Else
                // Si el codigo es igual, se compara el numero de calzado vendido para asignar el menor a min
                If (res[i].codigo = min.codigo) Then
                    If (res[i].numero < min.numero) Then
                        Begin
                            min := res[i];
                            posMin := i;
                        End;
        End;
    //Se carga en la var res los datos del detalle con menor codigo de calzado vendido,
    // y del menot al mayor talle, o el valor alto si se lleg¢ al final del archivo
    Leer(det[posMin], res[posMin]);
End;



Procedure Actualizar(Var M: maestro, Var d: detalle);

Var 
    res:   resto;
    min:   regResto;
    regM:   maestro;
Begin
    reset(M);
    For i:= 1 To cant_detalles Do
        Begin
            reset(d[i]);
            Leer(d[i], res[i]);
        End;
    //Se busca el menor codigo de calzado vendido entre los archivos detalle, y se guarda en min,
    //junto con la posici¢n del detalle al que corresponde
    minimo(d, res, min);
    regM.codigo := valor_alto;
    While (min.codigo <> valor_alto) Do
        Begin
            //Buscamos en el registro maestro el calzado a actualizar,
            // leyendo el archivo hasta encontrar el codigo del calzado vendido o llegar al final del archivo
            While (min.codigo <> reM.codigo) Do
                read(M, regM);
            While (regM.codigo = min.codigo) Do
                Begin
                    If (regM.numero = min.numero) Then
                        Begin
                            regM.cant_stock := regM.cant_stock - min.cant;
                            minimo(d, res, min);
                        End;
                End;
            // Una vez encontrado el calzado a actualizar en el archivo maestro, se regresa a la posici¢n del registro le¡do,
            // se actualiza su stock y se escribe el registro actualizado en el archivo maestro
            seek(M, filepos(M) - 1);
            write(M, regM);
        End;
End;

Var 
    det:   detalle;
    mae:   maestro;
    det:   String;

Begin
    assign(mae, 'maestro.dat');
    For i:= 1 To cant_detalles Do
        Begin
            Write('Ingrese el nombre del detalle ', i, ': ');
            readln(det);
            assign(det[i],det);
        End;
    Actualizar(mae, det);
    close(mae);
    For i:= 1 To cant_detalles Do
        close(det[i]);
End.
