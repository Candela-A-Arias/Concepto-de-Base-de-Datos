
Program MaterialesBinarios;

Const 
  F = 'fin'; {Constante para indicar el fin de la entrada de materiales}

Type 
  Material = Record
    nombre: string;
  End;
  ArchivoMateriales = file Of Material;
  {Tipo de archivo binario para almacenar materiales}
  Nodo = Record
    dato: Material;
    sig: ^Nodo;
  End;
  List = ^Nodo; {Puntero para manejar una lista de materiales}

Var 
  Construccion: ArchivoMateriales;
  {Variable para manejar el archivo binario de materiales}
  mat: Material; {Variable para leer los materiales del archivo}
  nombreArchivo: String; {Para llamar al archivo binario}
  L : list; {Lista para almacenar los materiales ingresados por el usuario}


Procedure agregarALista( Var L: List; mat: Material);

Var 
  aux: List;
Begin
  new(aux);
  aux^.dato := mat;
  aux^.sig := L;
  L := aux;
End;

Procedure IngresarMateriales(Var l: List);

Var 
  materiales : Material;
Begin
  writeln('Ingrese el nombbre del material, o fin para terminar');
  readln(materiales.nombre);
  While materiales <> F Do
    Begin
      agregarALista(l, Materiales);
      readln(materiales.nombre);
    End;
End;

Procedure GuardarMateriales(l: List; Var fileC: Construccion);

Var 
  m : Material;
Begin
  While (l <> null) do
    Begin
      m.nombre := l^.dato.nombre;
      write(fileC, m);
      l := l^.sig;
    End;
End;

Begin{Programa Principal}
  L := Nil; {Inicializar la lista de materiales}
  writeln("Ingrese el nombre del archivo binario para almacenar los materiales:"
  );
  readln(nombreArchivo);
  assign(Construccion, nombreArchivo);
  rewrite(Construccion);
  IngresarMateriales(L);
{Llamar al procedimiento para ingresar materiales y almacenarlos en la lista}
  GuardarMateriales(L, Construccion);

{Llamar al procedimiento para guardar los materiales de la lista en el archivo binario}
  close(Construccion);
  readln; {Esperar a que el usuario presione Enter antes de cerrar la consola}
End.
