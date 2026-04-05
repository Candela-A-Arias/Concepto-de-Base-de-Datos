
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


Procedure IngresarMateriales(Materiales: List);

Var 
  i: integer;
Begin
  writeln('Ingrese el nombbre del material, o fin para terminar');
End;

Procedure GuardarMateriales(filename: String);
Begin
  Assign(MaterialesConstruccion, filename);
  Reset(MaterialesConstruccion);
  Writeln('Materiales en el archivo:');
  While Not EOF(MaterialesConstruccion) Do
    Begin
      Read(MaterialesConstruccion, mat);
      Writeln('Nombre: ', mat.nombre);
    End;
  Close(MaterialesConstruccion);
End;

Begin{Programa Principal}
  List := Nil; {Inicializar la lista de materiales}
  writeln("Ingrese el nombre del archivo binario para almacenar los materiales:"
  );
  readln(nombreArchivo);
  assign(MaterialesConstruccion, nombreArchivo);
  rewrite(MaterialesConstruccion);
  IngresarMateriales(List);
  GuardarMateriales(List,MaterialesConstruccion);
  close(MaterialesConstruccion);
  readln; {Esperar a que el usuario presione Enter antes de cerrar la consola}
End.
