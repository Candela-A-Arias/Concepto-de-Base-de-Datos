
Program Ejercicio4;

Const 
    cines =   20;
    Fin =   9999;

Type 
    cine =   Record
        cod_pel:   integer;
        nombre:   string;
        genero:   string;
        director:   string;
        duracion:   integer;
        fecha:   longint;
        cant_asistentes:   integer;
    End;
    // Archivo detalle
    P_actuales =   file Of cine;
    detalle =   array [1..cines] Of P_actuales;
    Maestro =   file Of cine;
    // Vector para guardar los registros leidos de cada archivo detalle
    regCines =   array[1..cines] Of cine;



    // Se guarda en res los valores del archivo del vector detalle, 
    //o el valor alto si se lleg¢ al final del archivo
Procedure Leer(Var det: P_actuales, Var res: cine);
Begin
    If (Not eof(det)) Then
        read(det, res)
    Else
        res.cod_pel := Fin;
End;

Procedure minimo(Var d: detalle, Var r: regCines, Var min: cine);

Var 
    posMin:   integer;
Begin
    min := r[1];
    posMin := 1;
    For i:= 2 To cines Do
        Begin
            // Comprobamos si hay un codigo menor al asignado en min.
            If (r[i].cod_pel < min.cod_pel) Then
                Begin
                    min := r[i];
                    posMin := i;
                End;
        End;
    Leer(d[posMin], r[posMin]);
End;



// Crearemos un archivo maestro con los datos de los archivos detalle,
// en la ruta que indique la variable nom
Procedure CrearMaestro(Var m: P_actuales, String nom);

Var 
    m:   Maestro;
    c:   regCines;
    min, cine:   cine;
    i:   integer;
Begin
    assign(m, nom);
    For i:= 1 To cines Do
        Begin
            reset(det[i]);
            Leer(det[i], c[i]);
        End;
    rewrite(m);
    minimo(det, c, min);
    m.cod_pel := Fin;
    While (min.cod_pel <> Fin) Do
        Begin
            // primero guardamos los valores en un registro de tipo cine
            cine := min;
            cine.cant_asistentes := 0;
            While (min.cod_pel = m.cod_pel) Do
                Begin
                    cine.cant_asistentes := cine.cant_asistentes + min.cant_asistentes;
                    minimo(det, c, min);
                End;
            // Cuando tenemos TODOS los datos de todos los cines para una pel¡cula, se guarda en el archivo maestro.
            wriete(m, cine);
        End;
    Close(m);
    For i:= 1 To cines Do
        Close(det[i]);
End;

Var 
    m:   Maestro;
    det:   detalle;
    nom:   string;

Begin
    writeln('Ingrese el nombre del archivo maestro a crear:');
    readln(nom);
    For i:= 1 To cines Do
        Begin
            writeln('Ingrese el nombre del archivo detalle ', i, ':');
            readln(nom);
            assign(det[i], nom);
        End;
    CrearMaestro(m, nom);

End.
