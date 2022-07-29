program GetGrf;

uses crt;

type
  GIFHeader = record
    Signature : String [6];
    ScreenWidth,
    ScreenHeight : Word;
    Depth,
    Background,
    Zero : Byte;
  end;
  GIFDescriptor = record
    Separator : Char;
    ImageLeft,
    ImageTop,
    ImageWidth,
    ImageHeight : Word;
    Depth : Byte;
  end;

  RGB = record
    R,G,B: byte;
  end;

  AuxPalette = array [0..255] of RGB;


Procedure get_one(filename, balname:string);
var
  Header       : GIFHeader;
  Descriptor   : GIFDescriptor;
  GIFFile,f    : File;
  Palette      : AuxPalette;
  i            : byte;
begin

Write('Convertint ',filename,' en ',balname);

  Assign (GIFFile, filename);
  Reset (GIFFile, 1);

  Blockread (GIFFile, Header.Signature [1], sizeof (Header) - 1);

  BlockRead (GIFFile, Palette, 768);
  for i := 0 to 255 do begin
    Palette [i].r := Palette [i].r shr 2;
    Palette [i].g := Palette [i].g shr 2;
    Palette [i].b := Palette [i].b shr 2;
  end;

  Assign(f,balname);
  Rewrite(f,1);

repeat
  BlockRead(GIFFile,i,1);
  BlockWrite(f,i,1);
until EOF(GIFFile);

Close(GIFFile);

Close(f);

Writeln('   OK.');

end;

begin
clrscr;
Writeln('Arounders Grafics Conversor');
Writeln('===========================');
Writeln;

get_one('menu.gif'      ,       'grf01.agf');
get_one('hero.gif'      ,       'grf02.agf');
get_one('graph.gif'     ,       'grf03.agf');
get_one('back.gif'      ,       'grf04.agf');

Writeln;
Writeln('Tots els arxius procesats');

end.

