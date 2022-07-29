unit typedefs;

interface

type
{ ********************************************************************************* }
{ ** Tipus per a guardar el nivell                                               ** }
{ ********************************************************************************* }
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
{ ** Tipus per a guardar al heroi                                                ** }
{ ********************************************************************************* }

  TFrame = record
    off         : word;
    delay       : byte;
    moveX,moveY : shortint;
    sig         : byte;
  end;

  Tstate = record
    numFrames   : byte;
    Frame       : array[0..10] of TFrame;
  end;

  Thero = record                { principal }
    x,y         : integer;
    a           : word;
    id          : Word;
    delay       : byte;
    o           : word;
    actState    : byte;
    actFrame    : byte;
    State       : array[0..15] of Tstate;
  end;


implementation


end.