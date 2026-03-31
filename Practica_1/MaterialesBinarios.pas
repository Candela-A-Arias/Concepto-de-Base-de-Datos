program MaterialesBinarios;

Type 
  Material = Record
    nombre: string;
  End;

Var 
  fileVar: file Of Material;
  mat: Material;

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

  Assign(fileVar, filename);
  Rewrite(fileVar);

  For i := 1 To 4 Do
    Write(fileVar, materiales[i]);

  Close(fileVar);
  Writeln('Archivo binario ''', filename, ''' creado exitosamente.');
End;

Procedure LeerMateriales(filename: String);
Begin
  Assign(fileVar, filename);
  Reset(fileVar);
  Writeln('Materiales en el archivo:');
  While Not EOF(fileVar) Do
    Begin
      Read(fileVar, mat);
      Writeln('Nombre: ', mat.nombre);
    End;
  Close(fileVar);
End;

Begin
  EscribirMateriales('materiales.bin');
  LeerMateriales('materiales.bin');
  readln; {Esperar a que el usuario presione Enter antes de cerrar la consola}
End.