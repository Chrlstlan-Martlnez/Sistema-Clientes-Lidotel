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


function RepetidoGrup(Variable, Dato: string): boolean;
	var
		nCliente : Grupo;
	
	begin
		RepetidoGrup := False;
		AbrirArchivoGrup;
		
		if not eof(ArchivoGrupos) then
		begin
			case Variable of
				'Registro':begin
					while not eof(ArchivoGrupos) do
					begin
						read(ArchivoGrupos, nCliente);
						
						if nCliente.NumeroRegistro = Dato then
						begin
							RepetidoGrup := True;
							break;
						end;
					end;
				end;
				'Cedula':begin
					while not eof(ArchivoGrupos) do
					begin
						read(ArchivoGrupos, nCliente);
						
						if nCliente.Cedula = Dato then
						begin
							RepetidoGrup := True;
							break;
						end;
					end;
				end;
			end;
		end;
		Close(ArchivoGrupos);
	end;

function RepetidoAcom(Variable, Dato: string): boolean;
	var
		nCliente : Individual;
	
	begin
		RepetidoAcom := False;
		AbrirArchivoAcom;
		
		if not eof(ArchivoAcompanyados) then
		begin
			case Variable of
				'Registro':begin
					while not eof(ArchivoAcompanyados) do
					begin
						read(ArchivoAcompanyados, nCliente);
						
						if nCliente.NumeroRegistro = Dato then
						begin
							RepetidoAcom := True;
							break;
						end;
					end;
				end;
				'Cedula':begin
					while not eof(ArchivoAcompanyados) do
					begin
						read(ArchivoAcompanyados, nCliente);
						
						if nCliente.Cedula = Dato then
						begin
							RepetidoAcom := True;
							break;
						end;
					end;
				end;
			end;
		end;
		Close(ArchivoAcompanyados);
	end;

function RepetidoInd(Variable, Dato: string): boolean;
	var
		nCliente : Individual;
	
	begin
		RepetidoInd := False;
		AbrirArchivoInd;
		
		if not eof(ArchivoIndividuales) then
		begin
			case Variable of
				'Registro':begin
					while not eof(ArchivoIndividuales) do
					begin
						read(ArchivoIndividuales, nCliente);
						
						if nCliente.NumeroRegistro = Dato then
						begin
							RepetidoInd := True;
							break;
						end;
					end;
				end;
				'Cedula':begin
					while not eof(ArchivoIndividuales) do
					begin
						read(ArchivoIndividuales, nCliente);
						
						if nCliente.Cedula = Dato then
						begin
							RepetidoInd := True;
							break;
						end;
					end;
				end;
			end;
		end;
		Close(ArchivoIndividuales);
	end;

function TiposHabitacion(): string;
	var
		x: byte;

	begin
		writeln('Ingrese Tipo de Habitacion: ');
		writeln('1- FAMILY ROOM - 200$ por noche');
		writeln('2- SENCILLA - 60$ por noche');
		writeln('3- DOBLE - 120$ por noche');
		writeln('4- SUITE - 300$ por noche');
		
		readln(x);
		
		case x of
			1: TiposHabitacion := 'FAMILY ROOM';
			2: TiposHabitacion := 'SENCILLA';
			3: TiposHabitacion := 'DOBLE';
			4: TiposHabitacion := 'SUITE';
		end;
	end;

function DatosReservacion(Dato: string): string;
	var
		ValorDato: string;
	begin
		clrscr;
		case Dato of
			'Registro': 
			begin
				write('Ingrese Numero de Registro: ');
				readln(ValorDato);
				DatosReservacion := ValorDato;
			end;
			'Habitacion':
			begin
				DatosReservacion := TiposHabitacion;
			end;
			'Estadia':
			begin
				write('Ingrese Dias de Estadia: ');
				readln(ValorDato);
				DatosReservacion := ValorDato;
			end;
		end;
		
	end;
	
procedure FacturaGrup();
	Var
		CostoHabitacion: real;
		Noches: real;

	begin
		writeln('Factura del Cliente:');
		writeln('Numero de Registro: ', ListaGrupos[1].NumeroRegistro);
		writeln('Nombre: ', ListaGrupos[1].NombreC);
		writeln('Cedula: ', ListaGrupos[1].Cedula);
		writeln('Telefono: ', ListaGrupos[1].Telefono);
		writeln('Reservacion: ', ListaGrupos[1].Reservacion);
		writeln('Estadia: ', ListaGrupos[1].Estadia);
		writeln('Habitacion: ', ListaGrupos[1].TipoHabitacion);
		case ListaGrupos[1].TipoHabitacion of
			'FAMILY ROOM': CostoHabitacion := 200;
			'SENCILLA': CostoHabitacion := 60;
			'DOBLE': CostoHabitacion := 120;
			'SUITE': CostoHabitacion := 300;
		end;
		
		Noches:= StrToFloat(ListaGrupos[1].Estadia);
		
		writeln('Costo Total : ', (CostoHabitacion*Noches):0:2);
			
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;

	
procedure FacturaAcom();
	Var
		CostoHabitacion: real;
		Noches: real;

	begin
		writeln('Factura del Cliente:');
		writeln('Numero de Registro: ', ListaAcompanyados[1].NumeroRegistro);
		writeln('Nombre: ', ListaAcompanyados[1].NombreC);
		writeln('Cedula: ', ListaAcompanyados[1].Cedula);
		writeln('Telefono: ', ListaAcompanyados[1].Telefono);
		writeln('Reservacion: ', ListaAcompanyados[1].Reservacion);
		writeln('Estadia: ', ListaAcompanyados[1].Estadia);
		writeln('Habitacion: ', ListaAcompanyados[1].TipoHabitacion);
		case ListaAcompanyados[1].TipoHabitacion of
			'FAMILY ROOM': CostoHabitacion := 200;
			'SENCILLA': CostoHabitacion := 60;
			'DOBLE': CostoHabitacion := 120;
			'SUITE': CostoHabitacion := 300;
		end;
		
		Noches:= StrToFloat(ListaAcompanyados[1].Estadia);
		
		writeln('Costo Total : ', (CostoHabitacion*Noches):0:2);
			
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;

procedure FacturaInd();
	Var
		CostoHabitacion: real;
		Noches: real;

	begin
		writeln('Factura del Cliente:');
		writeln('Numero de Registro: ', ListaIndividuales[CantidadClientes].NumeroRegistro);
		writeln('Nombre: ', ListaIndividuales[CantidadClientes].NombreC);
		writeln('Cedula: ', ListaIndividuales[CantidadClientes].Cedula);
		writeln('Telefono: ', ListaIndividuales[CantidadClientes].Telefono);
		writeln('Reservacion: ', ListaIndividuales[CantidadClientes].Reservacion);
		writeln('Estadia: ', ListaIndividuales[CantidadClientes].Estadia);
		writeln('Habitacion: ', ListaIndividuales[CantidadClientes].TipoHabitacion);
		case ListaIndividuales[CantidadClientes].TipoHabitacion of
			'FAMILY ROOM': CostoHabitacion := 200;
			'SENCILLA': CostoHabitacion := 60;
			'DOBLE': CostoHabitacion := 120;
			'SUITE': CostoHabitacion := 300;
		end;
		
		Noches:= StrToFloat(ListaIndividuales[CantidadClientes].Estadia);
		
		writeln('Costo Total : ', (CostoHabitacion*Noches):0:2);
			
		writeln();
		writeln('Presione Enter para continuar');
		readln();
	end;


procedure CrearClienteGrupo();
	var
		i, nRegistros: byte;
		Regis, Habi, Estad: string;
		CedulaRepe, RegistroRepe: boolean;
	
	begin
		repeat
			Estad := DatosReservacion('Estadia');
			Habi := DatosReservacion('Habitacion');
			Regis := DatosReservacion('Registro');
			
			CedulaRepe := False;
			RegistroRepe := False;
			
			clrscr;
			write('Ingrese la cantidad de adultos: '); readln(nRegistros);
			
			
			for i:=1 to nRegistros do
			begin
				clrscr;
				
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
				ListaGrupos[i].Reservacion := TipoReser;
				ListaGrupos[i].Estadia := Estad;
				ListaGrupos[i].TipoHabitacion := Habi;
				ListaGrupos[i].NumeroRegistro := Regis;
				
				writeln();
				CedulaRepe := RepetidoGrup('Cedula', ListaGrupos[i].Cedula);
				RegistroRepe := RepetidoGrup('Registro', ListaGrupos[i].NumeroRegistro);
					
				if CedulaRepe = True then writeln('Esta cedula ya se encuentra en el sistema, ingrese un cliente nuevo.');
				if RegistroRepe = True then writeln('Este numero de registro ya existe, registre al usuario con otro numero.');
				
				writeln();
				writeln('Presione Enter para continuar');
				readln();
				
				if (CedulaRepe = True) or (RegistroRepe = True) then break;
			end;
		until (CedulaRepe = False) and (RegistroRepe = False);
		AnadirClienteGrup(nRegistros);
		FacturaGrup;
	end;

procedure CrearClienteAcom();
	var
		i: byte;
		Regis, Habi, Estad: string;
		CedulaRepe, RegistroRepe: boolean;
	
	begin
		repeat
			Estad := DatosReservacion('Estadia');
			Habi := DatosReservacion('Habitacion');
			Regis := DatosReservacion('Registro');
			
			CedulaRepe := False;
			RegistroRepe := False;
			
			for i:=1 to 2 do
			begin
				clrscr;
				
				write('Ingrese Nombre Completo: ');
				readln(ListaAcompanyados[i].NombreC);
				write('Ingrese Cedula: ');
				readln(ListaAcompanyados[i].Cedula);
				write('Ingrese Correo: ');
				readln(ListaAcompanyados[i].Correo);
				write('Ingrese Telefono: ');
				readln(ListaAcompanyados[i].Telefono);
				ListaAcompanyados[i].Reservacion := TipoReser;
				ListaAcompanyados[i].Estadia := Estad;
				ListaAcompanyados[i].TipoHabitacion := Habi;
				ListaAcompanyados[i].NumeroRegistro := Regis;
				
				writeln();
				CedulaRepe := RepetidoAcom('Cedula', ListaAcompanyados[i].Cedula);
				RegistroRepe := RepetidoAcom('Registro', ListaAcompanyados[i].NumeroRegistro);
					
				if CedulaRepe = True then writeln('Esta cedula ya se encuentra en el sistema, ingrese un cliente nuevo.');
				if RegistroRepe = True then writeln('Este numero de registro ya existe, registre al usuario con otro numero.');
				
				writeln();
				writeln('Presione Enter para continuar');
				readln();
				
				if (CedulaRepe = True) or (RegistroRepe = True) then break;
			end;
		until (CedulaRepe = False) and (RegistroRepe = False);
		AnadirClienteAcom;
		FacturaAcom;
	end;

procedure CrearClienteInd();
	var
		Regis, Habi, Estad: string;
		CedulaRepe, RegistroRepe: boolean;
	
	begin
		
		repeat
			Estad := DatosReservacion('Estadia');
			Habi := DatosReservacion('Habitacion');
			Regis := DatosReservacion('Registro');
			
			CedulaRepe := False;
			RegistroRepe := False;
			clrscr;
				
			write('Ingrese Nombre Completo: ');
			readln(ListaIndividuales[CantidadClientes].NombreC);
			write('Ingrese Cedula: ');
			readln(ListaIndividuales[CantidadClientes].Cedula);
			write('Ingrese Correo: ');
			readln(ListaIndividuales[CantidadClientes].Correo);
			write('Ingrese Telefono: ');
			readln(ListaIndividuales[CantidadClientes].Telefono);
			ListaIndividuales[CantidadClientes].Reservacion := TipoReser;
			ListaIndividuales[CantidadClientes].Estadia := Estad;
			ListaIndividuales[CantidadClientes].TipoHabitacion := Habi;
			ListaIndividuales[CantidadClientes].NumeroRegistro := Regis;
			
			writeln();
			CedulaRepe := RepetidoInd('Cedula', ListaIndividuales[CantidadClientes].Cedula);
			RegistroRepe := RepetidoInd('Registro', ListaIndividuales[CantidadClientes].NumeroRegistro);
			
			if CedulaRepe = True then writeln('Esta cedula ya se encuentra en el sistema, ingrese un cliente nuevo.');
			if RegistroRepe = True then writeln('Este numero de registro ya existe, registre al usuario con otro numero.');
			
			writeln();
			writeln('Presione Enter para continuar');
			readln();
			
		until (CedulaRepe = False) and (RegistroRepe = False);
		AnadirClienteInd;
		FacturaInd;
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
			writeln('Datos de los Clientes: ');
			while not eof(ArchivoIndividuales) do
			begin
				read(ArchivoIndividuales, nCliente);
				
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
			writeln('Cierre de Sistema..');
			readln();
			exit;
		end;
		
	end;
END.
