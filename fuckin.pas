program fuckin;

{ ********************************************************************************* }
{ **                                                                             ** }
{ **                    Brindiana Juan and the Fucking Machine                   ** }
{ **                                                                             ** }
{ **                                 v0.1 ALPHA 1                                ** }
{ **                                                                             ** }
{ **                         Copyright(c) JailDoctor 2000                        ** }
{ **                                                                             ** }
{ ********************************************************************************* }


uses Dgraf, Dkeyb, GifLoad, typedefs, sprdef;


{ ********************************************************************************* }
{ ** Constants per a manetjar al heroi                                           ** }
{ ********************************************************************************* }
const
  dreta         = 0;
  esquerra      = 10240;

  quiet         = 0;
  caminant      = 1;
  bot_curt      = 2;
  bot_llarg     = 3;
  caiguent      = 4;
  caiguent_avant= 5;
  bot_amunt     = 6;
  penjat        = 7;
  pujant        = 8;
  penjat_bal    = 9;
  mort          = 10;


{ ********************************************************************************* }
{ ** Variables globals                                                           ** }
{ ********************************************************************************* }
var
  VTiles     : PtrVScreen;      { Pantalla de tiles }
  Tiles      : Word;

  VSprHero   : PtrVScreen;      { Pantalla d'sprites de l'heroi }
  SprHero    : Word;

  VBack      : PtrVScreen;      { Pantalla del fondo }
  Back       : Word;

  VPrimary   : PtrVScreen;      { Pantalla primaria }
  Primary    : word;

  ExitSignal : boolean;         { senyal d'eixir del programa }
  delay      : word;            { retard del teclat }

  nivell     : TFase;           { fase actual }
  actNivell  : byte;            { nivell actual }

  hero       : Thero;           { heroi per defecte }



{ ********************************************************************************* }
{ ** Procediment que carrega un nivell                                           ** }
{ ********************************************************************************* }
Procedure LoadLevel;
var f : file of TFase;
begin
assign(f,'DEMO.BJL');
reset(f);
read(f,nivell);
close(f);
end;


{ ********************************************************************************* }
{ ** Procediment d'inicialització                                                ** }
{ ********************************************************************************* }
Procedure InitAll;
var
  x,y : byte;
  pal : AuxPalette;
begin

{ inicialitzar els grafics }
InitGraph;
InitVirtual(VTiles, Tiles);
InitVirtual(VSprHero, SprHero);
InitVirtual(VBack, Back);
InitVirtual(VPrimary, Primary);
cls(0,Primary);
cls(0,VGA);
LoadGIF('grf03.agf',Tiles);
LoadGIF('grf02.agf',SprHero);
LoadGIF('grf04.agf',Back);

{ inicialitzar el teclat }
InitKb;

{ menu de la demo (borrar!!) }
LoadPalette('pal01.apf',Pal);
RestorePalette(Pal);
LoadGIF('grf01.agf',VGA);
repeat until Qkeypress;
fadeout; cls(0,VGA);

LoadPalette('pal02.apf',Pal);
RestorePalette(Pal);


{ inicialitzar variables }
ExitSignal := False;
InitKb;

{ inicialitzar les tables d'sprites de l'heroi}
InitHero(hero);

{ inicialitzar fase }
LoadLevel;

{ comencem en el nivell 0 }
actNivell := 0;

end;

{ ********************************************************************************* }
{ ** Procediment de finalització                                                 ** }
{ ********************************************************************************* }
Procedure EndAll;
begin
fadeout;
EndKb;
EndVirtual(VTiles);
EndVirtual(VSprHero);
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
    If ord(missatge[i]) > 64 then PutSprite(tiles, 32000+((ord(missatge[i])-65) shl 3), address, x + ((i-1) shl 3), y, 8, 9);
    If ord(missatge[i]) < 64 then PutSprite(tiles, 32000+((ord(missatge[i])-22) shl 3), address, x + ((i-1) shl 3), y, 8, 9);
    end;
end;


{ ********************************************************************************* }
{ ** Procediment que comprova l'estat de les tecles                              ** }
{ ********************************************************************************* }
Procedure UpdateHero;
begin

{ s'en va al nivell de dalt }
If (Hero.actState = pujant) and (Hero.y = 2) then
  begin
  Hero.y := 170;
  actNivell := Nivell[actNivell].u;
  end;

If Hero.delay = 0 then
  begin
  Hero.actFrame := Hero.state[Hero.actState].frame[Hero.actFrame].sig;
  Hero.delay := Hero.state[Hero.actState].frame[Hero.actFrame].delay;
  If Hero.o = dreta then inc(Hero.x,Hero.state[Hero.actState].Frame[Hero.actFrame].moveX);
  If Hero.o = esquerra then dec(Hero.x,Hero.state[Hero.actState].Frame[Hero.actFrame].moveX);
  inc(Hero.y,Hero.state[Hero.actState].Frame[Hero.actFrame].moveY);
  end;
dec(Hero.delay);

{ s'en va al nivell de l'esquerra }
If Hero.x < 2 then
  begin
  Hero.x := 224;
  actNivell := Nivell[actNivell].l;
  end;

{ s'en va al nivell de la dreta }
If Hero.x > 224 then
  begin
  Hero.x := 2;
  actNivell := Nivell[actNivell].r;
  end;

Case Hero.actState of

quiet:
   begin
   { si no hi ha piso, caurà }
   If ((Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y+16) shr 3] < 1) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y+16) shr 3] > 5)) and
      (Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y+16) shr 3] <> 10) then
     begin
     Hero.actState := caiguent;
     Hero.actFrame := 0;
     exit;
     end;

   {si no està girant el cap... }
   If Hero.actFrame = 0 then
      begin

      { si es pulsa CTRL... }
      If keypress(keyRightCtrl) then
        begin
        { ... i DRETA, botarà cap a la dreta }
        If (keypress(keyArrowRight)) and (Hero.o = dreta) then
          begin
          Hero.actState := bot_curt;
          Hero.actFrame := 0;
          exit;
          end;
        { ... i ESQUERRA, botarà cap a l'esquerra }
        If (keypress(keyArrowLeft)) and (Hero.o = esquerra) then
          begin
          Hero.actState := bot_curt;
          Hero.actFrame := 0;
          exit;
          end;
        { ... i AMUNT, botarà cap amunt }
        If keypress(keyArrowUp) then
          begin
          Hero.actState := bot_amunt;
          Hero.actFrame := 0;
          exit;
          end;
        end
      { si no se pulsa CTRL ... }
      else
        begin
        { ...però se pulsa DRETA... }
        If keypress(keyArrowRight) then
          begin
          { ...si està mirant cap a l'esquerra, nomes girar-lo }
          If Hero.o = Esquerra then
            begin
            Hero.o := Dreta;
            exit;
            end
          { ...si està mirant cap a la dreta, començar a caminar }
          else
            begin
            Hero.actState := caminant;
            Hero.actFrame := 0;
            exit;
            end;
          end;
        { ...però se pulsa ESQUERRA... }
        If keypress(keyArrowLeft) then
          begin
          { ...si està mirant cap a la dreta, nomes girar-lo }
          If Hero.o = Dreta then
            begin
            Hero.o := Esquerra;
            exit;
            end
          { ...si està mirant cap a l'esquerra, començar a caminar }
          else
            begin
            Hero.actState := caminant;
            Hero.actFrame := 0;
            exit;
            end;
          end;

        end;
      end;
   end;

caminant:
   begin
   { si n'hi ha una paret davant, quietor }
   If (Hero.o = dreta) and (Nivell[actNivell].mapa.tiles[((Hero.x+6) shr 3)+1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     dec(Hero.x,2);
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   If (Hero.o = esquerra) and (Nivell[actNivell].mapa.tiles[((Hero.x+11) shr 3)-1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     inc(Hero.x,2);
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   { si no hi ha piso, caurà }
   If (Hero.delay = 0) and ((Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y+16) shr 3] < 1)
                       or (Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y+16) shr 3] > 5))
                       and (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] <> 10) then
     begin
     Hero.actState := caiguent;
     Hero.actFrame := 0;
     exit;
     end;

   { Si no continua caminant, pararà }
   If (Hero.o = dreta) and (not keypress(keyArrowRight)) and (hero.delay = 0) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   If (Hero.o = esquerra) and (not keypress(keyArrowLeft)) and (hero.delay = 0) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;

   { si pula CTRL botarà }
   If (keypress(keyRightCtrl)) and (Hero.delay = 0) then
     begin
     Hero.actState := bot_llarg;
     Hero.actFrame := 0;
     exit;
     end;
   end;

bot_curt:
   begin
   { pot segir avançant? }
   If (hero.delay = Hero.state[hero.actState].frame[hero.actFrame].delay-1) and
     (Hero.o = dreta) and (Nivell[actNivell].mapa.tiles[((Hero.x+6) shr 3)+1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     dec(Hero.x,Hero.state[hero.actState].frame[hero.actFrame].moveX);
     exit;
     end;
   If (hero.delay = Hero.state[hero.actState].frame[hero.actFrame].delay-1) and
     (Hero.o = esquerra) and (Nivell[actNivell].mapa.tiles[((Hero.x+11) shr 3)-1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     inc(Hero.x,Hero.state[hero.actState].frame[hero.actFrame].moveX);
     exit;
     end;

   { caura per un precipici? }
   If ((Hero.actFrame = 7) and (Hero.delay = 0) and (hero.o = dreta)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 10)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 10))
     or ((Hero.actFrame = 7) and (Hero.delay = 0) and (hero.o = esquerra)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 10)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 10)) then
     begin
     inc(Hero.y,3);
     Hero.actState := caiguent_avant;
     Hero.actFrame := 0;
     exit;
     end;

   { s'ha acavat el bot i ha caigut be }
   If (Hero.actFrame = 10) and (Hero.delay = 0) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   end;

bot_llarg:
   begin

   { pot segir avançant? }
   If (hero.delay = Hero.state[hero.actState].frame[hero.actFrame].delay-1) and
     (Hero.o = dreta) and (Nivell[actNivell].mapa.tiles[((Hero.x+6) shr 3)+1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     dec(Hero.x,Hero.state[hero.actState].frame[hero.actFrame].moveX);
     exit;
     end;
   If (hero.delay = Hero.state[hero.actState].frame[hero.actFrame].delay-1) and
     (Hero.o = esquerra) and (Nivell[actNivell].mapa.tiles[((Hero.x+11) shr 3)-1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     inc(Hero.x,Hero.state[hero.actState].frame[hero.actFrame].moveX);
     exit;
     end;

   { caura per un precipici? }
   If ((Hero.actFrame = 7) and (Hero.delay = 0) and (hero.o = dreta)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)+1,(Hero.y+19) shr 3] <> 10)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 10))
     or ((Hero.actFrame = 7) and (Hero.delay = 0) and (hero.o = esquerra)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3)-1,(Hero.y+19) shr 3] <> 10)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 1)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 5)
      and (Nivell[actNivell].mapa.tiles[((Hero.x+8) shr 3),(Hero.y+19) shr 3] <> 10)) then
     begin
     inc(Hero.y,3);
     Hero.actState := caiguent_avant;
     Hero.actFrame := 0;
     exit;
     end;

   { s'ha acavat el bot i ha caigut be }
   If (Hero.actFrame = 10) and (Hero.delay = 0) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   end;

caiguent:
   begin

   { incrementa l'altura de la que està caiguent }
   If (Hero.delay = 0) then inc(Hero.a);

   { s'en va al nivell de baix }
   If Hero.y >= 168 then
     begin
     Hero.y := 0;
     actNivell := Nivell[actNivell].d;
     end;

   { se vol enganxar i pot? }
   If (Hero.delay = 0) and (keypress(keyRightCtrl)) and
      ((Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 3) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 4)) then
     begin
     Hero.o := dreta;
     Hero.x := ((Hero.x shr 3) shl 3)+3;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat;
     Hero.actFrame := 0;
     Hero.a := 0;
     exit;
     end;
   If (Hero.delay = 0) and (keypress(keyRightCtrl)) and
      (Nivell[actNivell].mapa.tiles[(Hero.x+4) shr 3,(Hero.y) shr 3] = 5) then
     begin
     Hero.o := esquerra;
     Hero.x := (((Hero.x-4) shr 3) shl 3)+5;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat;
     Hero.actFrame := 0;
     Hero.a := 0;
     exit;
     end;

   { si xafa piso, ja no cau }
   If (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 1) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 5) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 10) then
     begin
     If Hero.a > 8 then
       begin
       Hero.actState := mort;
       Hero.actFrame := 0;
       exit;
       end
     else
       begin
       Hero.actState := quiet;
       Hero.actFrame := 0;
       Hero.a := 0;
       exit;
       end;
     end;
   end;

caiguent_avant:
   begin

   { incrementa l'altura de la que està caiguent }
   If (Hero.delay = 0) then inc(Hero.a);

   { s'en va al nivell de baix }
   If Hero.y >= 168 then
     begin
     Hero.y := 0;
     actNivell := Nivell[actNivell].d;
     end;

   { se vol enganxar i pot? }
   If (Hero.delay = 0) and (keypress(keyRightCtrl)) and (Hero.o = dreta) and
      ((Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 3) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 4)) then
     begin
     Hero.x := ((Hero.x shr 3) shl 3)+3;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat_bal;
     Hero.actFrame := 0;
     Hero.a := 0;
     exit;
     end;
   If (Hero.delay = 0) and (keypress(keyRightCtrl)) and (Hero.o = esquerra) and
      (Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y) shr 3] = 5) then
     begin
     Hero.x := (((Hero.x-2) shr 3) shl 3)+5;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat_bal;
     Hero.actFrame := 0;
     Hero.a := 0;
     exit;
     end;

   { si hi ha una paret davant, no avances }
   If (Hero.o = dreta) and (Nivell[actNivell].mapa.tiles[((Hero.x+6) shr 3)+1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     dec(Hero.x,2);
     end;
   If (Hero.o = esquerra) and (Nivell[actNivell].mapa.tiles[((Hero.x+11) shr 3)-1,((Hero.y+16) shr 3)-1] = 16) then
     begin
     inc(Hero.x,2);
     end;

   { si xafa piso, ja no cau }
   If (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 1) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 5) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y+16) shr 3] = 10) then
     begin
     If Hero.a > 8 then
       begin
       Hero.actState := mort;
       Hero.actFrame := 0;
       exit;
       end
     else
       begin
       Hero.actState := quiet;
       Hero.actFrame := 0;
       Hero.a := 0;
       exit;
       end;
     end;
   end;

bot_amunt:
   begin
   { si s'ha acavat el bot, quedat quiet }
   If (Hero.delay = 0) and (Hero.actFrame = 8) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;

   { se vol enganxar i pot? }
   { cas per a la dreta }
   If (Hero.delay = 0) and (Hero.actFrame = 6) and (keypress(keyRightCtrl)) and
      (Hero.o = dreta) and
      ((Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 3) or
      (Nivell[actNivell].mapa.tiles[(Hero.x+8) shr 3,(Hero.y) shr 3] = 4)) then
     begin
     Hero.x := ((Hero.x shr 3) shl 3)+3;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat;
     Hero.actFrame := 0;
     exit;
     end;
   { cas per a la esquerra }
   If (Hero.delay = 0) and (Hero.actFrame = 6) and (keypress(keyRightCtrl)) and
      (Hero.o = esquerra) and
      (Nivell[actNivell].mapa.tiles[(Hero.x+6) shr 3,(Hero.y) shr 3] = 5) then
     begin
     Hero.x := (((Hero.x-2) shr 3) shl 3)+5;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat;
     Hero.actFrame := 0;
     exit;
     end;
   { cas especial per a la esquerra (quan hi ha paret davant) }
   If (Hero.delay = 0) and (Hero.actFrame = 6) and (keypress(keyRightCtrl)) and
      (Hero.o = esquerra) and
      (Nivell[actNivell].mapa.tiles[(Hero.x) shr 3,(Hero.y) shr 3] = 5) and
      (Nivell[actNivell].mapa.tiles[(Hero.x) shr 3,(Hero.y+8) shr 3] = 16) then
     begin
     Hero.x := (((Hero.x-2) shr 3) shl 3)+2;
     Hero.y := ((Hero.y shr 3) shl 3)+2;
     Hero.actState := penjat;
     Hero.actFrame := 0;
     exit;
     end;

   end;

penjat:
   begin
   { Si no apretes CTRL... }
   If (not keypress(keyRightCtrl)) then
     begin
     { ...però apretes AMUNT, pujaràs }
     If keypress(keyArrowUp) then
       begin
       Hero.actState := pujant;
       Hero.actFrame := 0;
       exit;
       end
     { ...ni tampoc AMUNT, cauràs }
     else
       begin
       inc(Hero.y,2);
       Hero.actState := caiguent;
       Hero.actFrame := 0;
       exit;
       end;
     end;
   end;

pujant:
   begin
   { si ja ha pujat, que se quede quiet }
   If (Hero.delay = 0) and (Hero.actFrame = 3) then
     begin
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   end;

penjat_bal:
   begin
   { Si no apretes CTRL... }
   If (not keypress(keyRightCtrl)) then
     begin
     { ...però apretes AMUNT, pujaràs }
     If keypress(keyArrowUp) then
       begin
       Hero.actState := pujant;
       Hero.actFrame := 0;
       exit;
       end
     { ...ni tampoc AMUNT, cauràs }
     else
       begin
       inc(Hero.y,2);
       Hero.actState := caiguent;
       Hero.actFrame := 0;
       exit;
       end;
     end;
   end;

mort:
   begin
   If keypress(keySpace) then
     begin
     InitHero(Hero);
     actNivell := 0;
     Hero.actState := quiet;
     Hero.actFrame := 0;
     exit;
     end;
   end;

end;

end;


{ ********************************************************************************* }
{ ** Procediment que comprova l'estat de les tecles                              ** }
{ ********************************************************************************* }
Procedure CheckKeys;
var x : byte;
begin
If delay > 0 then dec(delay);

If KeyPress(keyESC) then ExitSignal := True;

{ DEBUG }
{If Keypress(keyEnter) then InitHero(hero);}

end;


{ ********************************************************************************* }
{ ** Procediment que ho pinta tot                                                ** }
{ ********************************************************************************* }
Procedure DrawAll;
var x,y : byte;
    t1 : string;
begin
flip(Back, Primary);

For x := 0 to 9 do
  If Nivell[actNivell].pilar[x].actiu then
    PutSprite(Tiles,16000,Primary,Nivell[actNivell].pilar[x].x,Nivell[actNivell].pilar[x].y,8,24);

For y := 0 to 22 do
  For x := 0 to 29 do
    PutSprite(Tiles, Nivell[actNivell].mapa.tiles[x,y] shl 3, Primary, (x+1) shl 3, (y+1) shl 3, 8, 8);

PutSprite(SprHero, hero.state[hero.actState].Frame[hero.actFrame].off+hero.o,
          Primary, hero.x, hero.y, 32, 32); { Pinta al heroe }

PutBloc(Back,0,Primary,0,0,320,8);
PutBloc(Back,61120,Primary,0,191,320,8);

For y := 0 to 22 do
  For x := 0 to 29 do
    IF ((Hero.y+16) shr 3 <> y) then
      PutSprite(Tiles, Nivell[actNivell].mapa.tiles[x,y] shl 3, Primary, (x+1) shl 3, (y+1) shl 3, 8, 8);

For x := 0 to 9 do
  If Nivell[actNivell].pilar[x].actiu then
    PutSprite(Tiles,16008,Primary,Nivell[actNivell].pilar[x].x,Nivell[actNivell].pilar[x].y,8,24);

If Hero.actState = mort then escriu(10,10,'PULSA SPACE PER COMENWAR',Primary);

{ Coordinades X Y i A (INFORMACIÓ DE DEBUG) }
{str(Hero.x:3,t1);
escriu(260,20,t1,Primary);
str(Hero.y:3,t1);
escriu(260,30,t1,Primary);
str(Hero.a:3,t1);
escriu(260,40,t1,Primary);}

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
  UpdateHero;
  DrawAll;
until ExitSignal;


EndAll;
end.