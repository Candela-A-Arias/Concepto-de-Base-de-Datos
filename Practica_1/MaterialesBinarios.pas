
Program stringesBinarios;

Const 
  F = 'fin'; {Constante para indicar el fin de la entrada de stringes}

Type 
   {Tipo de archivo binario para almacenar stringes}
  Nodo = Record
    dato: string;
    sig: ^Nodo;
  End;
  List = ^Nodo; {Puntero para manejar una lista de stringes}
  Archivo = file Of string;

Procedure agregarALista( Var L: List; mat: String);

Var 
  aux: List;
Begin
  new(aux);
  aux^.dato := mat;
  aux^.sig := L;
  L := aux;
End;

Procedure Ingresarstringes(Var l: List);

Var 
  materiales : string;
Begin
  writeln('Ingrese el nombbre del string, o fin para terminar');
  readln(materiales);
  While materiales <> F Do
    Begin
      agregarALista(l, materiales);
      readln(materiales);
    End;
End;

Procedure Guardarstringes(l: List; Var fileC: Archivo);

Var 
  m : string;
Begin
  While (l <> Nil) Do
    Begin
      m := l^.dato;
      write(fileC, m);
      l := l^.sig;
    End;
End;

Procedure MostrarArchivos(nombreArchivo: String);

Var 
  fileC: Archivo;
  m: string;
Begin
  assign(fileC, nombreArchivo);
  reset(fileC);
  writeln('Contenido del archivo ', nombreArchivo, ':');
  While Not eof(fileC) Do
    Begin
      read(fileC, m);
      writeln('Nombre del material: ', m);
    End;
  close(fileC);
End;

{Programa Principal}

Var 
  Construccion: Archivo;
  {Variable para manejar el archivo binario de stringes}
  nombreArchivo: String; {Para llamar al archivo binario}
  L : list; {Lista para almacenar los stringes ingresados por el usuario}


Begin
  L := Nil; {Inicializar la lista de stringes}
  writeln('Ingrese el nombre del archivo binario para almacenar los materiales:'
  );
  readln(nombreArchivo);
  assign(Construccion, nombreArchivo);
  rewrite(Construccion);
  Ingresarstringes(L);
  {Llamar al procedimiento para ingresar stringes y almacenarlos en la lista}
  Guardarstringes(L, Construccion);


{Llamar al procedimiento para guardar los stringes de la lista en el archivo binario}
  close(Construccion);
  MostrarArchivos(nombreArchivo);
  readln; {Esperar a que el usuario presione Enter antes de cerrar la consola}
End.
