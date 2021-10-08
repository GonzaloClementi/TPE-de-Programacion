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
