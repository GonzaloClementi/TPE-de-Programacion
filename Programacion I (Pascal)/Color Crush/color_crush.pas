program ColorCrush;
uses crt;
const
     maxcol = 8; // Columnas
     maxfil = 8;  // Filas
     maxarr = 10; // Arreglo
     maxmovimientos = 3; // Maximo de movimientos
type matriz = array [1..maxfil,1..maxcol] of char; // Tablero
     puntos = array [1..maxarr] of integer; // ArrPuntajes
     nombres = array [1..maxarr] of string[8]; // ArrNIcks
     colores = array [0..3] of char;

procedure corrimientonicks(var arr:nombres;pos:integer);
var j:integer;
begin
     j:=maxarr;
     while (j>pos) do
     begin
          arr[j]:=arr[j-1];
          j:=j-1;
     end;
end;
procedure corrimientopuntajes (var arr:puntos;pos:integer);
var j:integer;
begin
     j:=maxarr;
     while (j>pos) do
     begin
          arr[j]:=arr[j-1];
          j:=j-1;
     end;
end;
procedure cargarmatriz (var tablero:matriz;color:colores);
var i,j:integer;
begin
     i:=1;j:=1;
     randomize;
     while (i<=maxfil) do
     begin
          while (j<=maxcol) do
          begin
                tablero[i,j]:=color[random(4)];
                j:=j+1;
          end;
          j:=1;
          i:=i+1;
      end;
end;
procedure mostrarmatriz (tablero:matriz);
var i,j:integer;
begin
     j:=1;i:=1;
     while (j<=maxcol) do
     begin
          while (i<=maxfil) do
          begin
               if (i=maxfil) then
                 if (tablero[i,j]='R')then
                   begin
                        textcolor(red);
                        writeln (tablero[i,j]);
                   end
                 else
                   if (tablero[i,j]='B')then
                    begin
                        textcolor(white);
                        writeln (tablero[i,j]);
                    end
                   else
                    if (tablero[i,j]='V')then
                       begin
                            textcolor(green);
                            writeln (tablero[i,j]);
                       end
                    else
                        begin
                             textcolor(lightblue);
                             writeln (tablero[i,j]);
                        end
	       else
                 if (tablero[i,j]='R')then
                   begin
                        textcolor(red);
                        write(tablero[i,j],' ');
                   end
                 else
                   if (tablero[i,j]='B')then
                    begin
                         textcolor(white);
                         write(tablero[i,j],' ');
                    end
                   else
                    if (tablero[i,j]='V')then
                       begin
                            textcolor(green);
                            write(tablero[i,j],' ');
                       end
                    else
                        begin
                             textcolor(lightblue);
                             write(tablero[i,j],' ');
                        end;
	       i:=i+1;
	  end;
	 i:=1;
         j:=j+1;
     end;
     writeln(' ');
end;
procedure invertir (var tablero:matriz;i,j:integer;mov:string);
var pasaje:char;
begin
     if ((mov='ar') and (j>1)) then
	 begin
	      pasaje:=tablero[i,j];
	      tablero[i,j]:=tablero[i,j-1];
	      tablero[i,j-1]:=pasaje;
	 end
	 else
	     if ((mov='ab') and (j<maxcol)) then
		 begin
		      pasaje:=tablero[i,j];
		      tablero[i,j]:=tablero[i,j+1];
		      tablero[i,j+1]:=pasaje;
		 end
		 else
		     if ((mov='der') and (i<maxfil)) then
			 begin
			      pasaje:=tablero[i,j];
			      tablero[i,j]:=tablero[i+1,j];
                              tablero[i+1,j]:=pasaje;
			 end
			 else
			     if ((mov='izq') and (i>1)) then
				 begin
				      pasaje:=tablero[i,j];
				      tablero[i,j]:=tablero[i-1,j];
				      tablero[i-1,j]:=pasaje;
				 end;
end;
function haysecxcol (tablero:matriz):boolean;
var i,j:integer;encontre:boolean;
begin
     i:=1;j:=1;encontre:=false;
     while ((i<=maxfil) and (encontre=false)) do
     begin
          while ((j<=maxcol-2) and (encontre=false)) do
           if (((tablero[i,j])=(tablero[i,j+1]))and((tablero[i,j+1])=(tablero[i,j+2]))) then
            encontre:=true
           else
            j:=j+1;
      i:=i+1;
      j:=1;
      end;
      haysecxcol:=encontre;
end;
function haysecxfila (tablero:matriz):boolean;
var i,j:integer;encontre:boolean;
begin
     i:=1;j:=1;encontre:=false;
     while ((j<=maxcol) and (encontre=false)) do
     begin
          while ((i<=maxfil-2) and (encontre=false)) do
           if((tablero[i,j]=tablero[i+1,j])and(tablero[i+1,j]=tablero[i+2,j])) then
            encontre:=true
           else
            i:=i+1;
          j:=j+1;
          i:=1;
     end;
     haysecxfila:=encontre;
end;
procedure buscarsecxcol (tablero:matriz;var i,j1,j2:integer);
var poscol,posfil:integer;encontre:boolean;
begin
     i:=1;j1:=1;j2:=1;poscol:=1;posfil:=1;encontre:=false;
     while ((posfil<=maxfil) and (encontre=false)) do
     begin
          while ((poscol<=maxcol-2) and (encontre=false)) do
           if ((tablero[posfil,poscol]=tablero[posfil,poscol+1])and ((tablero[posfil,poscol+1])=(tablero[posfil,poscol+2]))) then
           begin
                encontre:=true;
                i:=posfil;
                j1:=poscol;
           end
           else
               poscol:=poscol+1;
     posfil:=posfil+1;
     poscol:=1;
     end;
     j2:=j1+2;
     while((j2<maxcol)and(tablero[i,j2]=tablero[i,j2+1]))do
          j2:=j2+1;
end;
procedure corrimientocol (var tablero:matriz;i,j1,j2:integer);
var aux:integer;
begin
     aux:=j1-1;
     while (aux>=1) do
     begin
          tablero[i,j2]:=tablero[i,aux];
          j2:=j2-1;
          aux:=aux-1;
     end;
end;
procedure rellenarvaciosxcol (var tablero:matriz;i,tamanio:integer;color:colores);
var j:integer;
begin
     j:=1;
     randomize;
     while (j<=tamanio) do
     begin
          tablero[i,j]:=color[random(3)];
          j:=j+1;
     end;
end;
function tamaniosec (pos1,pos2:integer):integer;
var contador:integer;
begin
     contador:=0;
	 while (pos1<=pos2) do
	 begin
	      contador:=contador+1;
		  pos1:=pos1+1;
	 end;
	 tamaniosec:=contador;
end;
function valorficha (tablero:matriz;i,j:integer):integer;
var aux:integer;
begin
     aux:=0;
	 if (tablero[i,j]='R') then
	  aux:=1
	 else
	  if (tablero[i,j]='V') then
	   aux:=2
	 else
	  if (tablero[i,j]='A') then
	   aux:=3
	 else
	  aux:=4;
	 valorficha:=aux;
end;
procedure buscarsecxfila (tablero:matriz;var i,i2,j:integer);
var encontre:boolean;aux,aux2:integer;
begin
     i:=1;i2:=1;j:=1;encontre:=false;
	 while ((j<=maxcol) and (encontre=false)) do
	   begin
	        while ((i<=maxfil-2) and (encontre=false)) do
		   if(((tablero[i,j])=(tablero[i+1,j]))and((tablero[i+1,j])=(tablero[i+2,j]))) then
		     begin
		          encontre:=true;
		          aux:=i;
                          aux2:=j
		     end
		   else
		    i:=i+1;
	        j:=j+1;
	        i:=1;
	   end;
	 i:=aux;
	 i2:=i+2;
         j:=aux2;
         while((i2<maxfil)and(tablero[i,j]=tablero[i+1,j])) do
           i2:=i2+1;
end;
procedure corrimientofila (var tablero:matriz;i,i2,j:integer);
var aux:integer;
begin
     aux:=j;
     while (i<=i2) do
       begin
            while(aux>1) do
              begin
	           tablero[i,aux]:=tablero[i,aux-1];
		   aux:=aux-1;
	      end;
	    aux:=j;
	    i:=i+1;
       end;
end;
procedure rellenarvacioxfila (var tablero:matriz;i,i2,j:integer;color:colores);
var aux,aux2:integer;
begin
     aux:=1;
     randomize;
     while(i<=i2) do
       begin
            if (aux<j) then
              begin
                while (aux<j) do
	          begin
	               tablero[i,aux]:=color[random(3)];
	               aux:=aux+1;
	          end;
	        aux:=1;
	        i:=i+1;
              end
            else
              begin
                   tablero[i,j]:=color[random(3)];
                   i:=i+1;
              end;
       end;
end;
procedure actualizarranking (var nicks:nombres;var puntajes:puntos;puntaje:integer;nick:string);
var i:integer;
begin
     i:=1;
     while ((i<=maxarr) and (puntaje<puntajes[i])) do
       i:=i+1;
     if (i<maxarr) then
       begin
            corrimientonicks(nicks,i);
            nicks[i]:=nick;
            corrimientopuntajes(puntajes,i);
            puntajes[i]:=puntaje;
       end
     else
       if((i=maxarr)and(puntaje>puntajes[i])) then
        begin
             nicks[i]:=nick;
             puntajes[i]:=puntaje;
        end;
end;
procedure mostrarranking (nicks:nombres;puntajes:puntos);
var i:integer;
begin
     i:=1;
	 writeln('ranking:');
	 while (i<=maxarr) do
	 begin
	      writeln (nicks[i],',',puntajes[i]);
	      i:=i+1;
	 end;
end;
procedure Nivel2 (var tablero:matriz;var nicks:nombres;var puntajes:puntos;color:colores);
var i,j,k,i2,j2:integer;puntaje:integer;mov:string;nick:string[8];
begin
     color[0]:='R';
     color[1]:='B';
     color[2]:='V';
     color[3]:='A';
     k:=1;puntaje:=0;i2:=1;j2:=1;
     write ('Ingrese Nick (Hasta 8 Caracteres):');
     readln (nick);
     cargarmatriz (tablero,color);
     mostrarmatriz (tablero);
     writeln('puntaje:',puntaje);
     while(k<=maxmovimientos) do
       begin
            textcolor(white);
            writeln ('Ingrese Posicion De La Ficha');
	    read(i);readln(j);
	    writeln ('Hacia Donde Va Mover? (ar/ab/izq/der)');
	    readln (mov);
	    invertir (tablero,i,j,mov);
	    mostrarmatriz (tablero);
	    while ((haysecxcol(tablero)=true) or (haysecxfila(tablero)=true)) do
	      begin
                   if ((haysecxcol(tablero)=true)) then
	             begin
	                  buscarsecxcol(tablero,i,j,j2);
                          puntaje:=(tamaniosec(j,j2)*valorficha(tablero,i,j))+puntaje;
			  corrimientocol(tablero,i,j,j2);
			  rellenarvaciosxcol(tablero,i,tamaniosec(j,j2),color);
		     end
		   else
                      begin
		          buscarsecxfila(tablero,i,i2,j);
                          corrimientofila(tablero,i,i2,j);
                          rellenarvacioxfila(tablero,i,i2,j,color);
                          puntaje:=(tamaniosec(i,i2)*valorficha(tablero,i,j))+puntaje;
                      end;

	      end;
            textcolor(white);
            k:=k+1;
            mostrarmatriz(tablero);
            writeln('puntaje:',puntaje);

     end;
     textcolor(white);
     actualizarranking(nicks,puntajes,puntaje,nick);
     mostrarranking(nicks,puntajes);
     readln();
end;
function nohaypuntajes (arr:puntos):boolean;
var tof:boolean; i:integer;
begin
     tof:=false;
	 i:=1;
	 while ((i<=maxarr) and (tof=false)) do
	 begin
	      if (arr[i] <> 0) then
		     tof:=true;
		  i:=i+1;
	end;
	nohaypuntajes:=tof;
end;
procedure cargarconpuntos(var nicks:nombres);
var i:integer;
begin
     i:=1;
	 while (i<=maxarr) do
	 begin
	      nicks[i]:='.';
		  i:=i+1;
	end;
end;
procedure cargarconceros (var puntajes:puntos);
var i:integer;
begin
     i:=1;
	 while (i<=maxarr) do
	 begin
	      puntajes[i]:=0;
		  i:=i+1;
	end;
end;
procedure Nivel1 (var tablero:matriz;var nicks:nombres;var puntajes:puntos;color:colores);
var a:integer;
begin
     clrscr;
     writeln('--------Color Crush--------');
     writeln('1.Juego Nuevo');
     writeln('2.Ranking');
     writeln('3.Salir');
     if (nohaypuntajes (puntajes)=true) then
       begin
            cargarconpuntos(nicks);
	    cargarconceros(puntajes);
       end;
     readln(a);
     if (a=1) then
       nivel2 (tablero,nicks,puntajes,color)
     else
       if(a=2) then
         begin
              mostrarranking(nicks,puntajes);
              readln();
         end;
end;
var tablero:matriz;nicks:nombres;puntajes:puntos;color:colores;
begin
     nivel1(tablero,nicks,puntajes,color);
end.
