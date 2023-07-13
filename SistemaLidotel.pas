program SistemaClientesLidotel;
//Geyser Velasquez
//Christian Martínez
//Proyecto 3 Programación 1

uses
	crt,
	SysUtils;
	
type
	Cliente=record
		NombreC: string;
		Cedula: string;
		Correo: string;
		Telefono: string;
		Estadia: string;
		TipoHabitacion: string;
		end;

	RegistrosClientes=array[1..100] of Cliente;
	
	
var
	Eleccion, CantidadClientes: byte;
	
	NombreArchivo: string;
	
	ListaClientes: RegistrosClientes;
	
	ArchivoClientes: file of Cliente;


Procedure AbrirArchivo();
	var
		CodigoError: integer;

	begin
		Assign(ArchivoClientes, NombreArchivo);
		{$I-}
		Reset(ArchivoClientes);
		CodigoError:=IOResult;
		{$I+}
		
		if CodigoError = 2 then
		begin
			Rewrite(ArchivoClientes);
		end;
	end;
	
	
procedure AnadirCliente();

	begin
		AbrirArchivo;
		
		seek(ArchivoClientes, filesize(ArchivoClientes));
		write(ArchivoClientes, ListaClientes[CantidadClientes]);
		Close(ArchivoClientes);
	end;
	
procedure CrearCliente(nCliente:byte);
	//var
	
	begin
		clrscr;
		writeln('Cliente numero ',nCliente);
		
		write('Ingrese Nombre Completo: ');
		readln(ListaClientes[nCliente].NombreC);
		write('Ingrese Cedula: ');
		readln(ListaClientes[nCliente].Cedula);
		write('Ingrese Correo: ');
		readln(ListaClientes[nCliente].Correo);
		write('Ingrese Telefono: ');
		readln(ListaClientes[nCliente].Telefono);
		write('Ingrese Dias de Estadia: ');
		readln(ListaClientes[nCliente].Estadia);
		write('Ingrese Tipo de Habitacion: ');
		readln(ListaClientes[nCliente].TipoHabitacion);
		
		writeln();
		writeln('Presione Enter para continuar');
		
		readln();
		AnadirCliente;
	end;


procedure MostrarCliente();
	var
		i, nCliente:byte;
	
	begin
		clrscr;
		writeln('Que Cliente desea ver?');
		for i:=1 to (CantidadClientes) do
		begin
			writeln(i, ' ', ListaClientes[i].NombreC);
		end;
		readln(nCliente);
		
		clrscr;
		writeln('Cliente numero ',nCliente);
		
		write('Nombre: ');
		writeln(ListaClientes[nCliente].NombreC);
		write('Cedula: ');
		writeln(ListaClientes[nCliente].Cedula);
		write('Correo: ');
		writeln(ListaClientes[nCliente].Correo);
		write('Telefono: ');
		writeln(ListaClientes[nCliente].Telefono);
		write('Dias de Estadia: ');
		writeln(ListaClientes[nCliente].Estadia);
		write('Tipo de Habitacion: ');
		writeln(ListaClientes[nCliente].TipoHabitacion);
		
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;





BEGIN
	NombreArchivo:= 'Clientes.dat';
	CantidadClientes:=0;
	
	AbrirArchivo;
	Close(ArchivoClientes);
	
	
	while True do
	begin
		clrscr;
		writeln('1- Anadir Cliente');
		writeln('2- Ver Cliente');
		writeln('3- Salir');
		readln(Eleccion);
		
		
		if Eleccion=1 then 
		begin
			CantidadClientes:= CantidadClientes+1;
			CrearCliente(CantidadClientes);
		end
		
		else if Eleccion=2 then
		begin
			MostrarCliente;
		end
		
		else if Eleccion=3 then
		begin
			exit;
		end;
		
	end;
END.
