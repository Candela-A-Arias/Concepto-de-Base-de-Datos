
Program Ejercicio5;

Type 
    informacion =   Record
        //primer orden
        partido:   string;
        //segundo orden
        localidad:   string;
        barrio:   string;
        cantidad_ni¤os:   integer;
        cantidad_adultos_mayores:   integer;
    End;

    // Dado que solo usaremos un archivo del cual se tiene almacenada la informaci¢n de cada municipio,
    // lo asumiremos como el archivo maestro, del cual extreremos la informaci¢n que nos piden imprimir en pantalla.

    municipio =   file Of informacion;

Procedure BusquedaEImpresion(Var maestro: municipio);

Var 
    info:   informacion;
    partido, localidad:   string;
    ni,adu, nip, adup :   integer;
Begin
    //Comprobamos que el archivo no est‚ vac¡o
    If (eof(maestro)) Then
        Begin
            // Si est  vac¡o, imprimimos un mensaje y salimos del procedimiento
            WriteLn('El archivo est  vac¡o.');
            exit;
        End
    Else
        Begin
            // Si no est  vac¡o, realizamos lo que nos piden
            read(maestro, info);
            While (Not(eof(maestro))) Do
                Begin
                    partido := info.partido;
                    writeln('Partido: ', partido);
                    nip := 0;
                    // contador de ni¤os para el partido
                    adup := 0;
                    // contador de adultos mayores para el partido
                    While (Not(eof(maestro)) And info.partido = partido) Do
                        Begin
                            localidad := info.localidad;
                            writeln('Localidad: ', localidad);
                            ni := 0;
                            // contador de ni¤os para la localidad
                            adu := 0;
                            // contador de adultos mayores para la localidad
                            While (Not(eof(maestro)) And info.localidad = localidad) Do
                                Begin
                                    ni := ni + info.cantidad_ni¤os;
                                    // sumamos la cantidad de ni¤os del barrio
                                    adu := adu + info.cantidad_adultos_mayores;
                                    //sumamos la cantidad de adultos del barrio 
                                    writeln('Cantidad de ni¤os: ', ni,'     ','Cantidad de adultos mayores: ', adu);
                                    read(maestro, info);
                                End;
                            nip := nip + ni;
                            // sumamos la cantidad de ni¤os de la localidad al contador del partido
                            adup := adup + adu;
                            // sumamos la cantidad de adultos mayores de
                            writeln('Total de ni¤os en la localidad ', localidad, ': ', ni, '     ', 'Total de adultos mayores en la localidad ', localidad, ': ', adu);
                        End;
                End;
        End;
End;


Var 
    nombre :   string;
    maestro :   municipio;
Begin
    //Solicitamos el ingreso del nombre del archivo
    Write('Ingrese el nombre del archivo: ');
    ReadLn(nombre);
    assign(maestro, nombre);
    reset(maestro);
    BusquedaEImpresion(maestro);
    close(maestro);
End.
