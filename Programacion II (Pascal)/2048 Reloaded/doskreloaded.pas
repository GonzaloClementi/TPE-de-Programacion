program doskreloaded;
uses crt;
const
    MaxCol = 4;
	MaxFil = 4;

type Matriz = array [1..MaxFil,1..MaxCol] of integer;


    EstJugadores = ^NodoArbol;
     NodoArbol = record
	    Nick:string[8];
		Password:string[8];
		PartidosFinalizados:Integer;
		Puntos:Real;
		PPendiente:boolean;
		Menores:EstJugadores;
		Mayores:EstJugadores;
		Sig:EstJugadores;
		Ant:EstJugadores;
	end;
	
	RecJug = record
	    Nick:string[8];
		Password:string[8];
		PartidosFinalizados:Integer;
		Puntos:Integer;
	end;
	
	ArchJug = file of RecJug;
	
	RecJugadas = record
	    Nick:string[8];
		PPendiente:boolean;
		Tablero:Matriz;
	end;
	
	Jugadas = file of RecJugadas;
	
	
//////////////////////////////////////////
procedure CargarEstJugadores (var Jugadores,Ranking:EstJugadores; var ArchJugadores:ArchJug; var ArchJugadas:Jugadas);
var AuxJug:RecJug; AuxJugadas:String[8];
begin
    Assign(ArchJugadores,'Jugadores.dat');
	{$I-}
	Reset (ArchJugadores);
	{$I+}
	If ioresult <> 0 then
       Rewrite (ArchJugadores);
	while not EoF (ArchJugadores) do 
	begin
	    Read (ArchJugadores, AuxJug);
		InsertarOrdArbol (Jugadores,AuxJug);
    end;
	close(ArchJugadores);
	Assign(ArchJugadas,'Jugadas.dat');
	{$I-}
	Reset (ArchJugadas);
	{$I+}
	If ioresult = 0 then 
	     while not EoF(ArchJugadas) do
		 begin
		      read(ArchJugadas.Nick,AuxJugadas);
			  BuscarEnArbol(Jugadores,Nick);
		 end;		  
    InsertarEnLista (Jugadores, Ranking);
end;

procedure BuscarEnArbol(var Jugadores:EstJugadores; Nick:string[8]);
begin  
     if (Jugadores^.Nick=Nick) then
	    Jugadores^.PPendiente:=true;
	 else 
	   if ( Jugadores<>nil) then
	     if(Jugadores^.Nick<nick) then
	       BuscarEnArbol(Jugadores^.Mayores,nick);
		  else
		   if (Jugadores^.Nick>nick) then
		      BuscarEnArbol(Jugadores^.Menores,nick);
end;

procedure InsertarEnLista (Jugadores:EstJugadores; var Ranking:EstJugadores);
begin
    If (Jugadores <> Nil) then
	begin
	    InsertarEnLista(Jugadores^.Menores, Ranking);
		InsertarOrdLista (Jugadores,Ranking);
		InsertarEnLista (Jugadores^.Mayores, Ranking);
	end;		
end;

Procedure InsertarOrdLista (Jugadores:EstJugadores; var Ranking:EstJugadores); 
var Cursor,AAgregar:EstJugadores;
begin
    Cursor:=Ranking; AAgregar:=Jugadores; AAgregar^.Sig:=Nil; AAgregar^.Ant:=Nil;
    If (Jugadores^.PartidosFinalizados = 0 ) then
	begin
	    if ((Cursor <> Nil) then
		begin
		  while  ((Cursor^.Sig <> Nil)) do
		    Cursor:=Cursor^.Sig;
		  Cursor^.Sig:=AAgregar;
		  Cursor^.Ant:=Cursor;
		end else
		  Ranking:=AAgregar;
	end else
	 begin
	    if ((Cursor<>nil) then begin
		  while ((Cursor^.Sig<>nil) and(Cursor^.Puntos/Cursor^.PartidosFinalizados)>(Jugadores^.Puntos/Jugadores^.PartidosFinalizados)) do
			Cursor:=Cursor^.Sig;
		  if(Cursor=Ranking) then begin
		    AAgregar^.Sig:=Cursor;
			Cursor^.Ant:=AAgregar;
			Ranking:=AAgregar;
		   end else begin
		     if ( Cursor^.Sig<>nil) then begin
			   Cursor^.Ant^.Sig:=AAgregar;
			   AAgregar^.Ant:=Cursor^.Ant;
			   AAgregar^.Sig:=Cursor;
			   Cursor^.Ant:=AAgregar;
			  end else begin
			    if((Cursor^.Puntos/Cursor^.PartidosFinalizados)>(Jugadores^.Puntos/Jugadores^.PartidosFinalizados)) then begin
				  Cursor^.Sig:=AAgregar;
				  AAgregar^.Ant:=Cursor;
				 end else begin
                    	Cursor^.Ant^.Sig:=AAgregar;
                        AAgregar^.Ant:=Cursor^.Ant;
			            AAgregar^.Sig:=Cursor;
			            Cursor^.Ant:=AAgregar;	
                     end;
                  end;
            end else
		   Ranking:=AAgregar;
	  end;
     		  
    end;
end;

Procedure Login (Jugadores:EstJugadores; var ArchJugadores:ArchJug; var ArchJugadas:Jugadas);
var Nick,Password:String[8];
begin
    writeln ('Ingrese Nick de Usuario');
	readln (Nick);
	Writeln ('Ingrese su Password');
	readln (Password);
    If (LoginCorrecto (Jugadores,Nick,Password)) then
	   Nivel2 (Jugadores,ArchJugadores,ArchJugadas,BuscarEnArbol(Jugadores,Nick));
	else
	    writeln ('Login Incorrecto');
end;

Procedure NuevoUsuario (var Jugadores,Ranking:EstJugadores);
var Usuario:RecJug; 
begin
    writeln ('Ingrese Nuevo Nick de Usuario');
	readln (Usuario.Nick);
	Writeln ('Ingrese Nueva Password');
	readln (Usuario.Password);
	
	If not (ExisteUsuario(Jugadores,Usuario.Nick) ) then
	begin
	    InsertarOrdArbol (Jugadores,Usuario);
		NuevoRanking (Jugadores,Ranking);
	end;
	else
	    writeln ('El usuario ya existe ! ');
end;

procedure NuevoRanking (Jugadores:EstJugadores; var Ranking:EstJugadores);
var Cursor,AAgregar:EstJugadores;
begin
    AAgregar:=Jugadores;
    if ((Cursor <> Nil) then
		begin
		  while  ((Cursor^.Sig <> Nil)) do
		    Cursor:=Cursor^.Sig;
		  Cursor^.Sig:=AAgregar;
		  Cursor^.Ant:=Cursor;
		end else
		  Ranking:=AAgregar;
end;

Procedure VerUsuarios (Jugadores:EstJugadores);
begin
    RecorrerArbol (Jugadores);
end;

Procedure VerRankings (Ranking:EstJugadores);
Cursor:EstJugadores;
begin
     Cursor:=Ranking
	 While (Cursor<>nil) do
	 begin
	       MostrarDatos(Cursor);
		   Cursor:=Cursor^.Sig;
	 end;
end;

Procedure MostrarDatos(NodoLista:EstJugadores);
begin
     write('Nick:'NodoLista^.Nick,' Partidos finalizados:',NodoLista^.PartidosFinalizados,' puntos:',NodoLista^.Puntos);
	 if(NodoLista^.PPendiente) then
	   writeln('Partida pendiente: si');
	 else
	   writeln ('Partida pendiente: no');
end;

Procedure Salir (Jugadores:EstJugadores; Ranking:EstJugadores; var ArchJugadores:ArchJug; var ArchJugadas:Jugadas);
begin
    Assign(ArchJugadores,'Jugadores.dat');
	reset(ArchJugadores);
    GuardarDatos(Jugadores,ArchJugadores,ArchJugadas);
	close(ArchJugadores);
end;

Procedure GuardarDatos (Jugadores:EstJugadores; var ArchJugadores:ArchJug);
var
begin
     If (Jugadores <> Nil) then
	begin
	    VolcarEnArchivo(Jugadores,ArchJugadores);
	    GuardarDatos (Jugadores^.Mayores,ArchJugadores);
        GuardarDatos (Jugadores^.Menores,ArchJugadores);
    end;
	 
end;

Procedure VolcarEnArchivo(Jugadores:EstJugadores; var ArchJugadores:ArchJug);
var aux:ArchJug;
begin
     aux.Nick:=Jugadores^.Nick;
	 aux.Password:=Jugadores^.Password;
	 aux.PartidosFinalizados:=Jugadores^.PartidosFinalizados;
	 aux.Puntos:=Jugadores^.Puntos;
	 write(ArchJugadores,aux);
end;

Function LoginCorrecto (Jugadores:EstJugadores; Nick,Password:string[8]):boolean;
var Correcto:Boolean;
begin
    If ((ExisteUsuario(Jugadores,Nick)) and ((NodoArbol(Jugadores,Nick)^.Password = Password)) then
	    Correcto:=True;
	else
	   Correcto:=False;
	
	LoginCorrecto:=Correcto;
end;

procedure Nivel2 (var Jugadores,Ranking:EstJugadores; var ArchJugadores:ArchJug; var ArchJugadas:Jugadas; NodoArbol:EstJugadores);
begin
    write('Nick:'NodoArbol^.Nick,' Partidos finalizados:',NodoArbol^.PartidosFinalizados,' puntos:',NodoArbol^.Puntos);
    write(' Ranking:', PuestoRanking(Ranking,NodoArbol^.Nick);
	if(NodoArbol^.PPendiente) then
	   writeln('Partida pendiente: si');
	 else
	   writeln ('Partida pendiente: no');
    writeln ('Elija una opcion');
	writeln ('1 - Continuar Partida');
	writeln ('2 - Comenzar Partida');
	writeln ('3 - Borrar Usuario');
	writeln ('4 - Logout');
    case Menu of 
	    1:ContinuarPartida (ArchJugadas,NodoArbol); // Falta
	    2:ComenzarPartida (ArchJugadas,NodoArbol);
	    3:BorrarUsuario (Jugadores,NodoArbol); // Falta
    end;
end;

Function PuestoRanking (Ranking:EstJugadores;Nick:String[8]):integer;
var Puesto:integer;
begin
    Puesto:=1;
    while (Ranking^.Nick <> Nick) do
	    Puesto:=Puesto+1;
	PuestoRanking:=Puesto;
end;

procedure ComenzarPartida (var ArchJugadas:Jugadas; var NodoArbol:EstJugadores);
var Tablero:Matriz; Termino:Boolean;
begin
    BorrarPartida(ArchJugadas,NodoArbol);
	CargarMatriz(Tablero);    
    for x:=1 to 2 do
	begin
	    GenerarDos(Tablero);
	end;
	Dosk(Tablero,Termino);
	If (Termino) then
	begin
        BorrarPartida(ArchJugadas,NodoArbol);
    	ActualizarAtributos (Tablero,NodoArbol);
		NodoArbol^.PPendiente:=False;
	end
	else
	    GuardarPartida(ArchJugadas,Tablero,NodoArbol);		
end;	

Procedure ActualizarAtributos (Tablero:Matriz; var NodoArbol:EstJugadores);
begin
    NodoArbol^.PartidosFinalizados:=NodoArbol^.PartidosFinalizados+1;
	NodoArbol^.Puntos:=NodoArbol^.Puntos+ CalcularPuntaje(Tablero);
	NodoArbol^.PPendiente:=false;
end;

Function CalcularPuntaje (Tablero:Matriz):Real;
begin
    if ( Sumo2048 (Tablero)) then
	    CalcularPuntaje:=1;
    else
        If (Sumo1024 (Tablero)) then
            CalcularPuntaje:=0,5;
        else
            if (Sumo512 (Tablero)) then
                CalcularPuntaje:=0,25;
            else
                CalcularPuntaje:=0;	
end;

Function Sumo2048 (Tablero:Matriz):boolean;
var i,j:integer; Encontre:Boolean;
begin
    i:=1; j:=1;
	Encontre:=False;
    while ((i <= MaxFil) and (not Encontre)) do
	begin
        while ((j <= MaxCol) and (not Encontre)) do
		begin
		    if (Tablero[i,j] = 2048) then
			    Encontre:=True;
			else
			    j:=j+1;
		end;
		i:=i+1;
		j:=1;
	end;
	Sumo2048:=Encontre;
end;

Function Sumo1024 (Tablero:Matriz):boolean;
var i,j:integer; Encontre:Boolean;
begin
    i:=1; j:=1;
	Encontre:=False;
    while ((i <= MaxFil) and (not Encontre)) do
	begin
        while ((j <= MaxCol) and (not Encontre)) do
		begin
		    if (Tablero[i,j] = 1024) then
			    Encontre:=True;
			else
			    j:=j+1;
		end;
		i:=i+1;
		j:=1;
	end;
	Sumo2048:=Encontre;
end;


Function Sumo512 (Tablero:Matriz):boolean;
var i,j:integer; Encontre:Boolean;
begin
    i:=1; j:=1;
	Encontre:=False;
    while ((i <= MaxFil) and (not Encontre)) do
	begin
        while ((j <= MaxCol) and (not Encontre)) do
		begin
		    if (Tablero[i,j] = 512) then
			    Encontre:=True;
			else
			    j:=j+1;
		end;
		i:=i+1;
		j:=1;
	end;
	Sumo2048:=Encontre;
end;

procedure GuardarPartida(var ArchJugadas:Jugadas;Tablero:Matriz;NodoArbol:EstJugadores);
var AuxJugadas:RecJugadas; Encontre:boolean;
begin
    Assign(ArchJugadas,'Jugadas.dat');
	{$I-}
	Reset (ArchJugadas);
	{$I+}
	If ioresult <> 0 then
	begin
       Rewrite (ArchJugadas);
       AuxJugadas.Nick:=NodoArbol^.Nick;
	   AuxJugadas.Tablero:=Tablero;
	   AuxJugadas.PPendiente:=True;
	   write (ArchJugadas, AuxJugadas);
	end
	else
    begin
	    Encontre:=false;
	    while (not EoF (ArchJugadas) and not (Encontre)) do
        begin
            If (NodoArbol^.Nick = ArchJugadas.Nick) then
                Encontre:=true;
			else
		        Read(ArchJugadas, AuxJugadas);
        end;    			
        AuxJugadas.Nick:=NodoArbol^.Nick;
	    AuxJugadas.Tablero:=Tablero;
	    AuxJugadas.PPendiente:=True;
	    write (ArchJugadas, AuxJugadas);   
    end;
	Close (ArchJugadas);
	NodoArbol^.PPendiente:=True;
end;

Procedure BorrarPartida (var ArchJugadas:Jugadas; NodoArbol:EstJugadores);
var Encontre:Boolean; Aux:RecJug;
begin
    Encontre:=False;
    if(NodoArbol^.PPendiente) then
	begin
	   assign (ArchJugadas, 'Jugadas.dat');
	   Reset (ArchJugadas);
	        while (not EoF (ArchJugadas) and not Encontre) do
			begin
			    If (NodoArbol^.Nick = ArchJugadas.Nick) then
				    Encontre:=True;
				else
				    Read (ArchJugadas, Aux);
			end;
			Aux.PPendiente:=False;
			write (ArchJugadas.PPendiente, Aux.PPendiente);	
       Close (ArchJugadas);			
	end;
end;

Procedure ContinuarPartida (var ArchJugadas:EstJugadores; var NodoArbol:EstJugadores);
var Tablero:Matriz; Termino:Boolean;
begin
    If (NodoArbol^.PPendiente) then
	begin
	    Tablero:=BuscarTablero (ArchJugadas,NodoArbol); 
    	 Dosk(Tablero,Termino);
	If (Termino) then
	begin
        BorrarPartida(ArchJugadas,NodoArbol);
    	ActualizarAtributos (Tablero,NodoArbol);
		NodoArbol^.PPendiente:=False;
	end
	else
	    GuardarPartida(ArchJugadas,Tablero,NodoArbol);		
    end;	
	end;
end;

Function BuscarTablero (ArchJugadas:Jugadas;NodoArbol:EstJugadores):Matriz;
var AuxJugadas:RecJugadas;
begin
    while not EoF (ArchJugadas) and (NodoArbol^.Nick <> ArchJugadas.Nick) do
	    Read (ArchJugadas, RecJugadas);
	write (ArchJugadas.Tablero, AuxJugadas.Tablero);
	BuscarTablero:=AuxJugadas.Tablero;
end;

Procedure Eliminar(var Jugadores:EstJugadores);
var AEliminar:EstJugadores;
begin
  AEliminar:=Jugadores;
  Jugadores^.Menores:=Nil;
  Jugadores^.Mayores:=Nil;
  Jugadores:=Nil;
  dispose(AEliminar);
end;

Procedure BuscarMayor(var ListaMenores:EstJugadores);
var Aux:EstJugadores;
begin
  if (ListaMenores^.Mayores <> Nil) then
    begin
      while (ListaMenores^.Mayores^.Mayores <> Nil) do
        ListaMenores:=ListaMenores^.Mayores;
      Aux:=ListaMenores^.Mayores;
      ListaMenores^.Mayores:=Aux^.Menores;
      ListaMenores:=Aux;
      Aux^.Mayores:=ListaMenores^.Menores;
    end;
end;

Procedure Intercambiar (var Jugadores:EstJugadores);
var NodoEliminar,NodoIntercambiar:EstJugadores;
begin
  NodoEliminar:=Jugadores;
  if (Jugadores^.Menores = Nil) then
    Jugadores:=Jugadores^.Mayores
  else
    begin
      NodoIntercambiar:=Jugadores^.Mayores;
      BuscarMayor(NodoIntercambiar);
      if (NodoIntercambiar <> Jugadores^.Menores) then
        NodoIntercambiar^.Menores:=Jugadores^.Menores;
      NodoIntercambiar^.Mayores:=Jugadores^.Mayores;
      Jugadores:=NodoIntercambiar;
    end;
  Eliminar(NodoEliminar);
end;

Procedure PosAEliminar (var Jugadores:EstJugadores;Nick:String[8]);
begin
  if (Jugadores^.Nick = Nick) then
    begin
      if (Jugadores^.Menores = Nil) and (Jugadores^.Mayores = Nil) then
        Eliminar(Jugadores)
        else
          Intercambiar(Jugadores);
    end
  else
    if (Jugadores^.Nick < Nick) then
      PosAEliminar(Jugadores^.Mayores, Nick)
  else
    if (Jugadores^.Nick > Nick) then
      PosAEliminar(Jugadores^.Menores,Nick);
end;

Procedure BorrarUsuario (var Jugadores:EstJugadores; Nick:String[8]);
begin
    PosAEliminar(Jugadores,Nick);
end;

Function ExisteUsuario (Jugadores:EstJugadores; Nick:String[8]):boolean;
var Existe:Boolean;
begin
    Existe:=false;
    If (Jugadores <> Nil) then
	  if (Jugadores^.Nick<Nick) then
	     ExisteUsuario:=ExisteUsuario(Jugadores^.Mayores,Nick);
	  else
	    If (Jugadores^.Nick>=Nick)and not(Existe) then
		  begin
		    ExisteUsuario:=ExisteUsuario (Jugadores^.Menores, Nick);
			if (Jugadores^.Nick=Nick)then 
			   Existe:=true;
			ExisteUsuario:=ExisteUsuario (Jugadores^.Mayores, Nick);
		  end;
	ExisteUsuario:=Existe;
end;

Procedure InsertarOrdArbol (var Jugadores:EstJugadores; Usuario:RecJug);
begin
    If (Jugadores = Nil) then
	    GenerarNodo (Jugadores,Usuario);
	else
	    If (Jugadores^.Nick > Nick) then
		    InsertarOrdArbol (Jugadores^.Menores,Usuario);
		else
		   InsertarOrdArbol (Jugadores^.Mayores,Usuario);
	
end;
procedure GenerarNodo(var Jugadores:EstJugadores; Usuario:RecJug);
begin
     New(Jugadores); 
	 Jugadores^.Menores:=nil;
	 Jugadores^.Mayores:=nil;
	 Jugadores^.Nick:=usuario.nick;
	 Jugadores^.Password:=Usuario.Password;
	 Jugadores^.PartidosFinalizados:=Usuario.PartidosFinalizados;
	 Jugadores^.Puntos:=Usuario.Puntos;
	 Jugadores^.pendiente:=false;
end;
Procedure RecorrerArbol (Jugadores:EstJugadores);
begin
    If (Jugadores <> Nil) then
	begin
	    RecorrerArbol (Jugadores^.Mayores);
		writeln (Jugadores^.Nick);
        RecorrerArbol (Jugadores^.Menores);
    end;
end;

procedure CargarMatriz (var Tablero:Matriz);
var i,j:integer;
begin
    i:=1;j:=1;    
    while (i<=MaxFil) do
    begin	    
        while (j<=MaxCol)do
        begin
		    Tablero[i,j]:=0;    		    
            j:=j+1;	           			
		end;        	
        j:=1;
        i:=i+1;	        		
    end;		
end;

procedure GenerarDos (var Tablero:Matriz);
var i,j:integer;GDos:boolean; 
begin
    GDos:=false;
    while (not GDos) do
	begin
	    randomize;
		i:=Random(4)+1; j:=Random(4)+1;
		if (Tablero[i,j] = 0) then
		begin
		    Tablero[i,j]:=2;
			GDos:=true;
		end;
	end;		
end;

Procedure MostrarMatriz(Tablero:Matriz);
var fila,columna:integer;
begin
    for fila:=1 to MaxFil do
    begin
        writeln('');
        for columna:=1 to MaxCol do
        begin		
            write(Tablero[fila,columna],' ');			
        end;
	end;
end;

function Haysecxcol (Tablero:matriz):boolean;
var i,j:integer; EncontreSec:boolean;
begin
    i:=1; j:=1; EncontreSec:=false;
	while (j < MaxCol) do
	begin	    
	    if (i <= MaxFil) then
		begin
		    if ((Tablero[i,j] = Tablero[i+1,j]) or (Tablero[i+1,j] = Tablero[i+2,j]) or (Tablero[i+2,j] = Tablero[i+3,j])) then
			begin
			    EncontreSec:=true;
			end;			
		end;		
	j:=j+1;
	end;
	Haysecxcol:=EncontreSec;	
end;

function Haysecxfil (Tablero:matriz):boolean;
var i,j:integer; EncontreSec:boolean;
begin
    i:=1; j:=1; EncontreSec:=false;
	while (i < MaxFil) do	
	begin	    
	    if (j <= MaxCol) then
		begin
		    if ((Tablero[i,j] = Tablero[i,j+1]) or (Tablero[i,j+1] = Tablero[i,j+2]) or (Tablero[i,j+2] = Tablero[i,j+3])) then
			begin
			    EncontreSec:=true;
			end;			
		end;		
	i:=i+1;
	end;
	Haysecxfil:=EncontreSec;	
end;

function QuedanMov (Tablero:Matriz):Boolean;
var i,j:integer; QuedanM:Boolean;
begin
    i:=1; j:=1; QuedanM:=false;
    while ((i<=MaxFil) and (QuedanM = false)) do
	begin
	    while ((j<=MaxCol) and (QuedanM = false)) do
		begin
		    if ( (Tablero[i,j] = 0) or (Haysecxcol(Tablero) = true) or (Haysecxfil(Tablero) = true) ) then
			begin
			    QuedanM:=True;				
			end;
	    j:=j+1;				
		end;
	j:=1;
	i:=i+1;		
	end;
	if (QuedanM <> false) then
    begin	
	    writeln('');
		writeln('');
        writeln('-> Todavia quedan movimientos <-');
	end; 		
	QuedanMov:=QuedanM;		
end;

procedure EstadoDelJuego (Tablero:Matriz);
var i,j,PC,PF:integer; DK:integer;
begin
    i:=1; j:=1; DK:=2048;
    while (j<=MaxCol) do
	begin
	    while (i<=MaxFil) do
		begin
		    if (Tablero[i,j] = DK ) then
			begin
				i:=MaxFil;
				j:=MaxCol-1;
				writeln ('');
				writeln ('-> 2048 <-');
	            writeln ('//-----------------------------------------------');
                writeln ('-> Ganaste !!! <-');
	            writeln ('//-----------------------------------------------');
			end;
		i:=i+1;
		end;
	j:=j+1;
	i:=1;				
	end;	
end;

function haymasvalARR(tablero:matriz;x,y:integer):boolean;
var encontre:boolean;
begin
     encontre:=false;
     while((x<=maxfil)and (not encontre))do
     begin
          if (tablero[x,y]<>0) then
             encontre:=true;
           x:=x+1;
     end;
     haymasvalARR:=encontre;
end;

function possigvalorARR (Tablero:Matriz;x,y:integer):integer;
begin
       while (Tablero[x,y] = 0) do
          x:=x+1;
       possigvalorARR:=x;		    
end;

procedure invertirFIL(var tablero:matriz;x,y,aux:integer);
var pasaje:integer;
begin
     pasaje:=tablero[x,y];
     tablero[x,y]:=tablero[aux,y];
     tablero[aux,y]:=pasaje;
end;

procedure CorrimientoARR (var Tablero:Matriz);
var x,y,aux:integer;
begin
    x:=1; y:=1;
	while (y <= MaxCol) do
	begin
	    while (x <= MaxFil) do
		begin
            if ((tablero[x,y]=0) and (haymasvalARR(tablero,x,y))) then
	        begin
    			invertirFIL(tablero,x,y,possigvalorARR(tablero,x,y));
			end;
	        x:=x+1;
		end;
	    x:=1;
	    y:=y+1;
	end;
end;

procedure JuntarARR (var Tablero:Matriz);
var i,j:integer;
begin
    i:=MaxFil; j:=1;
	CorrimientoARR(Tablero);
	while (j <= MaxCol) do
	begin
	    while (i > 1) do
		begin
		    if (Tablero[i,j] = Tablero[i-1,j]) then
			begin
			    Tablero[i-1,j]:=Tablero[i,j]+Tablero[i-1,j];
				Tablero[i,j]:=0;				              			
			end;			
    		i:=i-1;				
		end;
	i:=MaxFil;
	j:=j+1;
	end;	
end;

function haymasvalAB (tablero:matriz;x,y:integer):boolean;
var encontre:boolean;
begin
     encontre:=false;
     while((x >= 1)and (not encontre))do
     begin
          if (tablero[x,y]<>0) then
             encontre:=true;
           x:=x-1;
     end;
     haymasvalAB:=encontre;
end;

function possigvalorAB (Tablero:Matriz;x,y:integer):integer;
begin
       while (Tablero[x,y] = 0) do
          x:=x-1;
       possigvalorAB:=x;		    
end;

procedure CorrimientoAB (var Tablero:Matriz);
var x,y,aux:integer;
begin
    x:=MaxFil; y:=1;
	while (y <= MaxCol) do
	begin
	    while (x >= 1) do
		begin
            if ((tablero[x,y]=0) and (haymasvalAB(tablero,x,y))) then
	        begin
    			invertirFIL(tablero,x,y,possigvalorAB(tablero,x,y));
			end;
	        x:=x-1;
		end;
	    x:=MaxFil;
	    y:=y+1;
	end;
end;

procedure JuntarAB (var Tablero:Matriz);
var i,j:integer;
begin
    i:=MaxFil; j:=1;
	CorrimientoAB(Tablero);
	while (j <= MaxCol) do
	begin
	    while (i > 1) do
		begin
		    if (Tablero[i,j] = Tablero[i-1,j]) then
			begin
			    Tablero[i,j]:=Tablero[i,j]+Tablero[i-1,j];
				Tablero[i-1,j]:=0;
				i:=i-1;               			
			end;			
    		i:=i-1;				
		end;
	i:=MaxFil;
	j:=j+1;
	end;	
end;

function haymasvalDER(tablero:matriz;x,y:integer):boolean;
var encontre:boolean;
begin
     encontre:=false;
     while((y >= 1)and (not encontre))do
     begin
          if (tablero[x,y]<>0) then
             encontre:=true;
           y:=y-1;
     end;
     haymasvalDER:=encontre;
end;

function possigvalorDER (Tablero:Matriz;x,y:integer):integer;
begin
       while (Tablero[x,y] = 0) do
          y:=y-1;
       possigvalorDER:=y;		    
end;

procedure invertirCOL(var tablero:matriz;x,y,aux:integer);
var pasaje:integer;
begin
     pasaje:=tablero[x,y];
     tablero[x,y]:=tablero[x,aux];
     tablero[x,aux]:=pasaje;
end;

procedure CorrimientoDER (var Tablero:Matriz);
var x,y,aux:integer;
begin
    x:=1; y:=MaxCol;
	while (x <= MaxCol) do
	begin
	    while (y >= 1) do
		begin
            if ((tablero[x,y]=0) and (haymasvalDER(tablero,x,y))) then
	        begin
    			invertirCOL(tablero,x,y,possigvalorDER(tablero,x,y));
			end;
	        y:=y-1;
		end;
	    x:=x+1;
	    y:=MaxCol;
	end;
end;

procedure JuntarDER (var Tablero:Matriz);
var i,j:integer;
begin
    i:=1; j:=MaxCol;
	CorrimientoDER(Tablero);
	while (i <= MaxFil) do
	begin
	    while (j > 1) do
		begin
		    if (Tablero[i,j] = Tablero[i,j-1]) then
			begin
			    Tablero[i,j]:=Tablero[i,j]+Tablero[i,j-1];
				Tablero[i,j-1]:=0;
				j:=j-1;               			
			end;			
    		j:=j-1;				
		end;
	j:=MaxCol;
	i:=i+1;
	end;	
end;

function haymasvalIZQ(tablero:matriz;x,y:integer):boolean;
var encontre:boolean;
begin
     encontre:=false;
     while((y<=MaxCol)and (not encontre))do
     begin
          if (tablero[x,y]<>0) then
             encontre:=true;
           y:=y+1;
     end;
     haymasvalIZQ:=encontre;
end;

function possigvalorIZQ (Tablero:Matriz;x,y:integer):integer;
begin
       while (Tablero[x,y] = 0) do
          y:=y+1;
       possigvalorIZQ:=y;		    
end;

procedure CorrimientoIZQ (var Tablero:Matriz);
var x,y,aux:integer;
begin
    x:=1; y:=1;
	while (x <= MaxFil) do
	begin
	    while (y <= MaxCol) do
		begin
            if ((tablero[x,y]=0) and (haymasvalIZQ(tablero,x,y))) then
	        begin
    			invertirCOL(tablero,x,y,possigvalorIZQ(tablero,x,y));
			end;
	        y:=y+1;
		end;
	    x:=x+1;
	    y:=1;
	end;
end;

procedure JuntarIZQ (var Tablero:Matriz);
var i,j:integer;
begin
    i:=1; j:=1;
	CorrimientoIZQ(Tablero);
	while (i <= MaxFil) do
	begin
	    while (j < MaxCol) do
		begin
		    if (Tablero[i,j] = Tablero[i,j+1]) then
			begin
			    Tablero[i,j]:=Tablero[i,j]+Tablero[i,j+1];
				Tablero[i,j+1]:=0;
				j:=j+1;               			
			end;			
    		j:=j+1;				
		end;
	j:=1;
	i:=i+1;
	end;	
end;

Procedure Dosk (var Tablero:Matriz; var Termino:Boolean);
var x:integer; mov:string; sal:boolean;
begin
    clrscr;
	sal:=false;
	writeln ('-> 2048 <-');
	MostrarMatriz(Tablero);	
	while (QuedanMov(Tablero) and (not sal)) do
	begin
	    writeln ('');
	    writeln ('-> Hacia donde va a mover? - ARR/AB/IZQ/DER <-');
		writeln ('');
		writeln ('-> Desea salir del juego? - Salir <-');	
	    readln(mov);			
        if (mov='arr') then
		begin
		    JuntarARR(Tablero);
			GenerarDos(Tablero);
		end
        else
	        if (mov='ab') then
		    begin
		       JuntarAB(Tablero);
		       GenerarDos(Tablero);
			end
         	else
		        if (mov='der') then
			    begin
			        JuntarDER(Tablero);
					GenerarDos(Tablero);
				end
        		else
		      	    if (mov='izq') then
					begin
           			    JuntarIZQ(Tablero);
						GenerarDos(Tablero);
                    end;
                    if (mov='salir') then
                        begin
                            sal:=true;
                        end;							
	writeln ('-> 2048 <-');	
    MostrarMatriz(Tablero);     
	EstadoDelJuego(Tablero);
    end;
	If (not sal) then
	begin
    	writeln ('');
	    writeln ('');
   	    writeln ('//-----------------------------------------------');
        writeln ('-> No quedan mas movimientos, haz perdido <-');
	    writeln ('//-----------------------------------------------');
	    writeln ('');
	    readln();
	    readln;
		Termino:=True;
    end
	else
	   Termino:=false;
	
end;


///////////////////////////////////////////////////////////////////////////////////////////////////


var Tablero:Matriz; Jugadores:EstJugadores; Ranking:EstJugadores; ArchJugadores:ArchJug; ArchJugadas:Jugadas; Menu:Integer;
begin
    CargarEstJugadores (Jugadores,Ranking,ArchJugadores,ArchJugadas);
    Nivel1 (Menu);
	while (Menu <> 5) do
	begin
	    case Menu of 
	    1:Login (Jugadores);
	    2:NuevoUsuario (Jugadores);
	    3:VerUsuarios (Jugadores);
	    4:VerRankings (Ranking);
    	end;  
	    Nivel1 (Menu);
	end:
	Salir (Jugadores,Ranking,ArchJugadores,ArchJugadas);
   
end.
