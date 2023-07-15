program SistemaClientesLidotel;
//Geyser Velasquez
//Christian Martínez
//Proyecto 3 Programación 1

uses
	crt,
	SysUtils;
	
type
	Individual=record
		NombreC: string;
		Cedula: string;
		Correo: string;
		Telefono: string;
		Estadia: string;
		Reservacion: string;
		TipoHabitacion: string;
		NumeroRegistro: string;
		end;
	Grupo=record
		NombreC: string;
		Cedula: string;
		Correo: string;
		Telefono: string;
		NombreNino: string;
		EdadNino: string;
		Estadia: string;
		Reservacion: string;
		TipoHabitacion: string;
		NumeroRegistro: string;
		end;

	RegistrosIndividuales=array[1..100] of Individual;
	RegistrosAcompanyados=array[1..100] of Individual;
	RegistrosGrupos=array[1..100] of Grupo;
	
	
var
	Eleccion, CantidadClientes: byte;
	
	NombreArchivoI, NombreArchivoA, NombreArchivoG, TipoReser: string;
	
	ListaIndividuales: RegistrosIndividuales;
	ListaAcompanyados: RegistrosAcompanyados;
	ListaGrupos: RegistrosGrupos;
	
	ArchivoIndividuales: file of Individual;
	ArchivoAcompanyados: file of Individual;
	ArchivoGrupos: file of Grupo;



function TipoReservacion(): string;
	var
		EleccionReservacion: byte;
	begin
		EleccionReservacion:=0;
		
		while (EleccionReservacion <> 1) and (EleccionReservacion <> 2) and (EleccionReservacion <> 3) do
		begin
			clrscr;
			writeln('Elija el tipo de Reservacion');
			writeln('');
			writeln('1- Individual');
			writeln('2- Acompanyado');
			writeln('3- Grupo/Familia');
			readln(EleccionReservacion);
			
			case EleccionReservacion of
				1: TipoReservacion:= 'Individual';
				2: TipoReservacion:= 'Acompanyado';
				3: TipoReservacion:= 'Grupo';
			end;
		end;
	end;
	
	
procedure AbrirArchivoGrup();
	var
		CodigoError: integer;

	begin
		Assign(ArchivoGrupos, NombreArchivoG);
		{$I-}
		Reset(ArchivoGrupos);
		CodigoError:=IOResult;
		{$I+}
		
		if CodigoError = 2 then
		begin
			Rewrite(ArchivoGrupos);
		end;
	end;
		
procedure AbrirArchivoAcom();
	var
		CodigoError: integer;

	begin
		Assign(ArchivoAcompanyados, NombreArchivoA);
		{$I-}
		Reset(ArchivoAcompanyados);
		CodigoError:=IOResult;
		{$I+}
		if CodigoError = 2 then
		begin
			Rewrite(ArchivoAcompanyados);
		end;
	end;
	
procedure AbrirArchivoInd();
	var
		CodigoError: integer;

	begin
		Assign(ArchivoIndividuales, NombreArchivoI);
		{$I-}
		Reset(ArchivoIndividuales);
		CodigoError:=IOResult;
		{$I+}
		if CodigoError = 2 then
		begin
			Rewrite(ArchivoIndividuales);
		end;
	end;
	
	
procedure AnadirClienteGrup(nPersonas: byte);
	var
		i: byte;
		
	begin
		AbrirArchivoGrup;
		for i:=1 to nPersonas do
		begin
			seek(ArchivoGrupos, filesize(ArchivoGrupos));
			write(ArchivoGrupos, ListaGrupos[i]);
		end;
		
		Close(ArchivoGrupos);
	end;
	
procedure AnadirClienteAcom();
	var
		i: byte;
		
	begin
		AbrirArchivoAcom;
		for i:=1 to 2 do
		begin
			seek(ArchivoAcompanyados, filesize(ArchivoAcompanyados));
			write(ArchivoAcompanyados, ListaAcompanyados[i]);
		end;
		
		Close(ArchivoAcompanyados);
	end;
	
procedure AnadirClienteInd();

	begin
		AbrirArchivoInd;
		seek(ArchivoIndividuales, filesize(ArchivoIndividuales));
		write(ArchivoIndividuales, ListaIndividuales[CantidadClientes]);
		
		Close(ArchivoIndividuales);
	end;
	
procedure CrearClienteGrupo();
	var
		i, nRegistros: byte;
	
	begin
		write('Ingrese la cantidad de adultos: '); readln(nRegistros);
		
		
		for i:=1 to nRegistros do
		begin
			clrscr;
			writeln('Registro numero ',CantidadClientes);
			
			write('Ingrese Nombre Completo: ');
			readln(ListaGrupos[i].NombreC);
			write('Ingrese Cedula: ');
			readln(ListaGrupos[i].Cedula);
			write('Ingrese Correo: ');
			readln(ListaGrupos[i].Correo);
			write('Ingrese Telefono: ');
			readln(ListaGrupos[i].Telefono);
			write('Ingrese Nombre del nino: ');
			readln(ListaGrupos[i].NombreNino);
			write('Ingrese Edad del nino: ');
			readln(ListaGrupos[i].EdadNino);
			write('Ingrese Dias de Estadia: ');
			readln(ListaGrupos[i].Estadia);
			ListaGrupos[i].Reservacion := TipoReser;
			write('Ingrese Tipo de Habitacion: ');
			readln(ListaGrupos[i].TipoHabitacion);
			write('Ingrese Numero de Registro: ');
			readln(ListaGrupos[i].NumeroRegistro);
			
			writeln();
			writeln('Presione Enter para continuar');
		end;
		
		readln();
		AnadirClienteGrup(nRegistros);
	end;

procedure CrearClienteAcom();
	var
		i: byte;
	
	begin
		for i:=1 to 2 do
		begin
			clrscr;
			writeln('Registro numero ',CantidadClientes);
			
			write('Ingrese Nombre Completo: ');
			readln(ListaAcompanyados[i].NombreC);
			write('Ingrese Cedula: ');
			readln(ListaAcompanyados[i].Cedula);
			write('Ingrese Correo: ');
			readln(ListaAcompanyados[i].Correo);
			write('Ingrese Telefono: ');
			readln(ListaAcompanyados[i].Telefono);
			write('Ingrese Dias de Estadia: ');
			readln(ListaAcompanyados[i].Estadia);
			ListaAcompanyados[i].Reservacion := TipoReser;
			write('Ingrese Tipo de Habitacion: ');
			readln(ListaAcompanyados[i].TipoHabitacion);
			write('Ingrese Numero de Registro: ');
			readln(ListaAcompanyados[i].NumeroRegistro);
			
			writeln();
			writeln('Presione Enter para continuar');
		end;
		
		readln();
		AnadirClienteAcom;
	end;

procedure CrearClienteInd();
	
	begin
		clrscr;
		writeln('Registro numero ',CantidadClientes);
			
		write('Ingrese Nombre Completo: ');
		readln(ListaIndividuales[CantidadClientes].NombreC);
		write('Ingrese Cedula: ');
		readln(ListaIndividuales[CantidadClientes].Cedula);
		write('Ingrese Correo: ');
		readln(ListaIndividuales[CantidadClientes].Correo);
		write('Ingrese Telefono: ');
		readln(ListaIndividuales[CantidadClientes].Telefono);
		write('Ingrese Dias de Estadia: ');
		readln(ListaIndividuales[CantidadClientes].Estadia);
		ListaIndividuales[CantidadClientes].Reservacion := TipoReser;
		write('Ingrese Tipo de Habitacion: ');
		readln(ListaIndividuales[CantidadClientes].TipoHabitacion);
		write('Ingrese Numero de Registro: ');
		readln(ListaIndividuales[CantidadClientes].NumeroRegistro);
		
		writeln();
		writeln('Presione Enter para continuar');
		
		readln();
		AnadirClienteInd;
	end;


procedure MostrarClientesGrup();
	var
		nCliente: Grupo;
	
	begin
		clrscr;
		
		
		AbrirArchivoGrup;
		if not eof(ArchivoGrupos) then
		begin
			writeln('Datos de los Clientes: ');
			
			while not eof(ArchivoGrupos) do
			begin
				read(ArchivoGrupos, nCliente);
				
				writeln('');
				write('Numero de Registro: ');
				writeln(nCliente.NumeroRegistro);
				write('Nombre: ');
				writeln(nCliente.NombreC);
				write('Cedula: ');
				writeln(nCliente.Cedula);
				write('Correo: ');
				writeln(nCliente.Correo);
				write('Telefono: ');
				writeln(nCliente.Telefono);
				write('Nino: ');
				writeln(nCliente.NombreNino);
				write('Edad: ');
				writeln(nCliente.EdadNino);
				write('Dias de Estadia: ');
				writeln(nCliente.Estadia);
				write('Tipo de Habitacion: ');
				writeln(nCliente.TipoHabitacion);
			end;
		end;
		Close(ArchivoGrupos);
		
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;

procedure MostrarClientesAcom();
	var
		nCliente: Individual;
	
	begin
		clrscr;
		
		
		AbrirArchivoAcom;
		if not eof(ArchivoAcompanyados) then
		begin
			writeln('Datos de los Clientes: ');
			
			while not eof(ArchivoAcompanyados) do
			begin
				
				read(ArchivoAcompanyados, nCliente);
				
				writeln('');
				write('Numero de Registro: ');
				writeln(nCliente.NumeroRegistro);
				write('Nombre: ');
				writeln(nCliente.NombreC);
				write('Cedula: ');
				writeln(nCliente.Cedula);
				write('Correo: ');
				writeln(nCliente.Correo);
				write('Telefono: ');
				writeln(nCliente.Telefono);
				write('Dias de Estadia: ');
				writeln(nCliente.Estadia);
				write('Tipo de Habitacion: ');
				writeln(nCliente.TipoHabitacion);
			end;
		end;
		Close(ArchivoAcompanyados);
		
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;

procedure MostrarClientesInd();
	var
		nCliente: Individual;
	
	begin
		clrscr;
		
		
		AbrirArchivoInd;
		if not eof(ArchivoIndividuales) then
		begin
			
			while not eof(ArchivoIndividuales) do
			begin
				read(ArchivoIndividuales, nCliente);
				
				writeln('Datos de los Clientes: ');
				writeln('');
				write('Numero de Registro: ');
				writeln(nCliente.NumeroRegistro);
				write('Nombre: ');
				writeln(nCliente.NombreC);
				write('Cedula: ');
				writeln(nCliente.Cedula);
				write('Correo: ');
				writeln(nCliente.Correo);
				write('Telefono: ');
				writeln(nCliente.Telefono);
				write('Dias de Estadia: ');
				writeln(nCliente.Estadia);
				write('Tipo de Habitacion: ');
				writeln(nCliente.TipoHabitacion);
			end;
		end;
		Close(ArchivoIndividuales);
		
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;





BEGIN
	NombreArchivoI:= 'ClientesIndividuales.dat';
	NombreArchivoA:= 'ClientesAcompanyados.dat';
	NombreArchivoG:= 'ClientesGrupos.dat';
	CantidadClientes:=0;
	
	AbrirArchivoInd;
	Close(ArchivoIndividuales);
	AbrirArchivoAcom;
	Close(ArchivoAcompanyados);
	AbrirArchivoGrup;
	Close(ArchivoGrupos);
	
	
	while True do
	begin
		clrscr;
		writeln('1- Anadir Cliente');
		writeln('2- Ver Clientes');
		writeln('3- Salir');
		readln(Eleccion);
		
		if Eleccion=1 then 
		begin
			TipoReser:= TipoReservacion;
			CantidadClientes:= CantidadClientes+1;
			case TipoReser of
				'Individual': CrearClienteInd;
				'Acompanyado': CrearClienteAcom;
				'Grupo': CrearClienteGrupo;
			end;
		end
		
		else if Eleccion=2 then
		begin
			TipoReser:= TipoReservacion;
			case TipoReser of
				'Individual': MostrarClientesInd;
				'Acompanyado': MostrarClientesAcom;
				'Grupo': MostrarClientesGrup;
			end;
		end
		
		else if Eleccion=3 then
		begin
			exit;
		end;
		
	end;
END.
