program aee2_editor;

uses Dgraf, Dmouse, Dkeyb, GifLoad;

{ ********************************************************************************* }
{ ** Tipus per a guardar el mapa                                                 ** }
{ ********************************************************************************* }
type
  Tmapa = record
    tiles         : array[0..29,0..22] of byte;
  end;

  TPilar = record
    x,y           : word;
    actiu         : boolean;
  end;

  Tnivell = record
    l,r,u,d       : byte;
    mapa          : Tmapa;
    pilar         : array[0..9] of Tpilar;
  end;

  TFase = array[0..63] of Tnivell;

{ ********************************************************************************* }
{ ** Variables globals                                                           ** }
{ ********************************************************************************* }
var
  VTiles : PtrVScreen;          { Pantalla de tiles }
  Tiles : Word;

  VBack : PtrVScreen;           { Pantalla del fondo }
  Back : Word;

  VPrimary : PtrVScreen;        { Pantalla primaria }
  Primary : word;

  ExitSignal : boolean;         { senyal de eixir del programa }
  delay: word;                  { retard del teclat }

  nivell : TFase;               { On guardem tota la fase }

  actNivell : byte;             { nivell actual }

  brush : byte;                 { tile seleccionat per a pintar }


{ ********************************************************************************* }
{ ** Procediment que borra el nivell actual                                      ** }
{ ********************************************************************************* }
Procedure ClearNivell(z: byte);
var x,y : byte;
begin
nivell[z].l := 0;
nivell[z].r := 0;
nivell[z].u := 0;
nivell[z].d := 0;
For y := 0 to 22 do
  For x := 0 to 29 do
    nivell[z].mapa.tiles[x,y] := 0;
For x := 0 to 9 do nivell[z].pilar[x].actiu := False;
end;


{ ********************************************************************************* }
{ ** Procediment que borra TOTA la fase                                          ** }
{ ********************************************************************************* }
Procedure ClearAll;
var z: byte;
begin
For z := 0 to 63 do
  ClearNivell(z);
end;


{ ********************************************************************************* }
{ ** Procediment d'inicialització                                                ** }
{ ********************************************************************************* }
Procedure InitAll;
begin
InitGraph;
InitMouse;
InitKb;
InitVirtual(VTiles, Tiles);
InitVirtual(VBack, Back);
InitVirtual(VPrimary, Primary);

LoadGIF('logoed.gif',Primary);          { presentació }
flip(Primary,VGA);
repeat until (mouse1) or (QkeyPress);
fadeout;
cls(0,Primary);
cls(0,VGA);

LoadGIF('graph.gif',Tiles);
LoadGIF('back.gif',Back);
ExitSignal := False;

ClearAll;

brush := 0;
delay := 0;
actNivell := 0;
end;

{ ********************************************************************************* }
{ ** Procediment de finalització                                                 ** }
{ ********************************************************************************* }
Procedure EndAll;
begin
fadeout;
EndKb;
EndMouse;
EndVirtual(VTiles);
EndVirtual(VBack);
EndVirtual(VPrimary);
EndGraph;
end;


{ ********************************************************************************* }
{ ** Procediment que escriu text en pantalla                                     ** }
{ ********************************************************************************* }
Procedure Escriu(x,y: word; missatge: string; address: word);
var i: byte;
begin
For i := 1 to length(missatge) do
  If ord(missatge[i]) <> 32 then
    begin
    If ord(missatge[i]) > 64 then PutSprite(tiles, 38400+((ord(missatge[i])-65) shl 3), address, x + ((i-1) shl 3), y, 8, 9);
    If ord(missatge[i]) < 64 then PutSprite(tiles, 38400+((ord(missatge[i])-22) shl 3), address, x + ((i-1) shl 3), y, 8, 9);
    end;
end;


{ ********************************************************************************* }
{ ** Procediment que carrega un nivell                                           ** }
{ ********************************************************************************* }
Procedure LoadLevel;
var f : file of TFase;
begin
assign(f,'../level.bjl');
reset(f);
read(f,nivell);
close(f);
end;


{ ********************************************************************************* }
{ ** Procediment que salva un nivell                                             ** }
{ ********************************************************************************* }
Procedure SaveLevel;
var f : file of TFase;
begin
assign(f,'../level.bjl');
rewrite(f);
write(f,nivell);
close(f);
end;



Function GetNum: byte;
var
  cadena: string;
  pausa: word;
begin
pausa := 50000;
cadena := '';
repeat
  escriu(160,100,cadena,VGA);
  If pausa > 0 then dec(pausa);
  If pausa = 0 then
    begin
    repeat until Qkeypress;
    pausa := 50000;
    If keypress(key0) then cadena := cadena + '0';
    If keypress(key1) then cadena := cadena + '1';
    If keypress(key2) then cadena := cadena + '2';
    If keypress(key3) then cadena := cadena + '3';
    If keypress(key4) then cadena := cadena + '4';
    If keypress(key5) then cadena := cadena + '5';
    If keypress(key6) then cadena := cadena + '6';
    If keypress(key7) then cadena := cadena + '7';
    If keypress(key8) then cadena := cadena + '8';
    If keypress(key9) then cadena := cadena + '9';
    end;
until keypress(keyEnter) or keypress(keyESC);
GetNum := 0;
If keypress(keyEnter) then
  begin
  If length(cadena) = 2 then GetNum := ((Ord(cadena[1])-48)*10)+(Ord(cadena[2])-48);
  If length(cadena) = 1 then GetNum := Ord(cadena[1])-48;
  end;
end;

{ ********************************************************************************* }
{ ** Procediment que comprova l'estat de les tecles                              ** }
{ ********************************************************************************* }
Procedure CheckKeys;
var x : byte;
begin
{ canviar el tile seleccionat }
If (keypress(keyArrowRight)) and (brush < 20) and (delay = 0) then begin inc(brush); delay := 10; end;
If (keypress(keyArrowLeft)) and (brush > 0) and (delay = 0) then begin dec(brush); delay := 10; end;

If delay > 0 then dec(delay);

{ Eixir al pulsar ESC }
If KeyPress(keyESC) then ExitSignal := True;

{ Carregar un nivell al pulsar C }
If (keypress(keyC)) then
  begin
  LoadLevel;
  end;

{ Salvar un nivell al pulsar S }
If (keypress(keyS)) then
  begin
  SaveLevel;
  end;

{ anar/canviar el nivell de la dreta }
If (mouseX>247) and (mousex<256) and (mousey>7) and (mousey<192) and (delay = 0) then
  begin
  If mouse2 then Nivell[actNivell].r := getNum;
  If mouse1 then begin actNivell := Nivell[actNivell].r; delay := 10; end;
  end;

{ anar/canviar el nivell de l'esquerra }
If (mousex<8) and (mousey>7) and (mousey<192) and (delay = 0) then
  begin
  If mouse2 then Nivell[actNivell].l := getNum;
  If mouse1 then begin actNivell := Nivell[actNivell].l; delay := 10; end;
  end;

{ anar/canviar el nivell de dalt }
If (mouseX>7) and (mousex<248) and (mousey<8) and (delay = 0) then
  begin
  If mouse2 then Nivell[actNivell].u := getNum;
  If mouse1 then begin actNivell := Nivell[actNivell].u; delay := 10; end;
  end;

{ anar/canviar el nivell de baix }
If (mouseX>7) and (mousex<248) and (mousey>191) and (delay = 0) then
  begin
  If mouse2 then Nivell[actNivell].d := getNum;
  If mouse1 then begin actNivell := Nivell[actNivell].d; delay := 10; end;
  end;


{ Si estem dins de la zona de edició... }
If (mouseX>7) and (mousex<248) and (mousey>7) and (mousey<192) then
  begin

  { pintar el tile seleccionat al pulsar botó esquerre del ratolí }
  If (mouse1) then nivell[actNivell].mapa.tiles[(mousex shr 3)-1, (mousey shr 3)-1] := brush;

  { borrar al pulsar botó dret del ratolí }
  If (mouse2) then nivell[actNivell].mapa.tiles[(mousex shr 3)-1, (mousey shr 3)-1] := 0;

  { agafar el tile sobre el que estem i seleccionar-lo al pular ENTER }
  If (keypress(keyEnter)) then brush := nivell[actNivell].mapa.tiles[(mousex shr 3)-1, (mousey shr 3)-1];

  { Ficar un pilar al pulsar P }
  If (keypress(keyP)) then
    begin
    x := 0; delay := 10;
    while (nivell[actNivell].pilar[x].actiu) and (x < 10) do inc(x);
    If x <> 10 then
      begin
      nivell[actNivell].pilar[x].actiu := True;
      nivell[actNivell].pilar[x].x := (mouseX shr 3) shl 3;
      nivell[actNivell].pilar[x].y := ((mouseY shr 3) shl 3)-16;
      end;
    end;

  { Borrar un pilar al pulsar O }
  If (keypress(keyO)) then
    begin
    x := 0; delay := 10;
    repeat
      If (nivell[actNivell].pilar[x].x = (mouseX shr 3) shl 3) and (nivell[actNivell].pilar[x].y = ((mouseY shr 3) shl 3)-16)
        then nivell[actNivell].pilar[x].actiu := False;
      inc(x);
    until x = 10;
    end;
  end;

end;

{ ********************************************************************************* }
{ ** Procediment que ho pinta tot                                                ** }
{ ********************************************************************************* }
Procedure DrawAll;
var
  x,y : byte;
  t1,t2 : string;
begin
flip(Back, Primary);

For x := 0 to 9 do
  If nivell[actNivell].pilar[x].actiu then
    PutSprite(Tiles,16000,Primary,nivell[actNivell].pilar[x].x,nivell[actNivell].pilar[x].y,8,24);

For y := 0 to 22 do
  For x := 0 to 29 do
    PutSprite(Tiles, nivell[actNivell].mapa.tiles[x,y] shl 3, Primary, (x+1) shl 3, (y+1) shl 3, 8, 8);

For x := 0 to 9 do
  If nivell[actNivell].pilar[x].actiu then
    PutSprite(Tiles,16008,Primary,nivell[actNivell].pilar[x].x,nivell[actNivell].pilar[x].y,8,24);

PutBloc(Tiles, brush shl 3, Primary, 278, 160, 8, 8);


If (mouseX>7) and (mousex<248) and (mousey>7) and (mousey<192) then
  begin
  PutSprite(Tiles,2560 ,Primary, (mouseX shr 3) shl 3, (mouseY shr 3) shl 3, 8, 8);
  str(((mousex shr 3)-1):2,t1); t2 := t1; str(((mousey shr 3)-1):2,t1); t2 := t2+' '+t1;
  escriu(260,20,t2,Primary);
  end;

{ Pinta el numeret del nivell actual }
str(actNivell:2,t1);
escriu(284, 30,t1,Primary);

{ Pinta el numeret del nivell a la dreta }
str(Nivell[actNivell].r,t1);
escriu(248,100,t1,Primary);

{ Pinta el numeret del nivell a la esquerra }
str(Nivell[actNivell].l,t1);
escriu(  0,100,t1,Primary);

{ Pinta el numeret del nivell de damunt }
str(Nivell[actNivell].u,t1);
escriu(126,  0,t1,Primary);

{ Pinta el numeret del nivell de baix }
str(Nivell[actNivell].d,t1);
escriu(126,190,t1,Primary);


PutSprite(Tiles,32000,Primary, mouseX, mouseY, 8, 16);

WaitRetrace;
flip(Primary, VGA);
end;


{ ********************************************************************************* }
{ ** Programa principal                                                          ** }
{ ********************************************************************************* }
begin
InitAll;

repeat
  CheckKeys;
  DrawAll;
until ExitSignal;


EndAll;
end.