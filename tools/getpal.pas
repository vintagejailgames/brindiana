program GetPal;

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

Procedure get_one(filename,balname:string);
var
  Header       : GIFHeader;
  Descriptor   : GIFDescriptor;
  GIFFile      : File;
  f            : file of AuxPalette;
  Palette      : AuxPalette;
  i            : byte;
begin
  Write('Agafant ',balname,' de ',filename);

  Assign (GIFFile, filename);
  Reset (GIFFile, 1);

  Blockread (GIFFile, Header.Signature [1], sizeof (Header) - 1);

  BlockRead (GIFFile, Palette, 768);
  for i := 0 to 255 do begin
    Palette [i].r := Palette [i].r shr 2;
    Palette [i].g := Palette [i].g shr 2;
    Palette [i].b := Palette [i].b shr 2;
  end;
  Close(GIFFile);

  Assign(f,balname);
  Rewrite(f);
  Write(f,Palette);
  Close(f);

  Writeln('   OK.');
end;

begin
clrscr;
Writeln('Arounders Paleta Conversor');
Writeln('===========================');
Writeln;

get_one('menu.gif'      ,       'pal01.apf');
get_one('hero.gif'      ,       'pal02.apf');

Writeln;
Writeln('Tots els arxius procesats');

end.
