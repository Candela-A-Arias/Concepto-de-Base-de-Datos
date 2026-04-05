program MaterialesBinarios;

Type 
  Material = Record
    nombre: string;
  End;
  ArchivoMateriales = file Of Material; {Tipo de archivo binario para almacenar materiales}

Var 
Construccion: ArchivoMateriales; {Variable para manejar el archivo binario de materiales}
mat: Material; {Variable para leer los materiales del archivo}
nombreArchivo: String; {Para llamar al archivo binario}


Procedure EscribirMateriales(filename: String);
Var 
  materiales: array[1..4] Of Material;
  i: integer;
Begin
  { Inicializar materiales de ejemplo }
  materiales[1].nombre := 'Acero';

  materiales[2].nombre := 'Cemento';

  materiales[3].nombre := 'Madera';

  materiales[4].nombre := 'Vidrio';

  Assign(MaterialesConstruccion, filename);
  Rewrite(MaterialesConstruccion);

  For i := 1 To 4 Do
    Write(MaterialesConstruccion, materiales[i]);

  Close(MaterialesConstruccion);
  Writeln('Archivo binario ''', filename, ''' creado exitosamente.');
End;

Procedure LeerMateriales(filename: String);
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

Begin
  writeln("Ingrese el nombre del archivo binario para almacenar los materiales:");
  readln(nombreArchivo);
  assign(MaterialesConstruccion, nombreArchivo);
  rewrite(MaterialesConstruccion);
  EscribirMateriales(nombreArchivo);
  LeerMateriales(nombreArchivo);
  readln; {Esperar a que el usuario presione Enter antes de cerrar la consola}
End.