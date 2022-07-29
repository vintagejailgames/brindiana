UNIT Dmouse;

INTERFACE

PROCEDURE InitMouse;

FUNCTION  EndMouse: BOOLEAN;

Function  MouseX: Word;
Function  MouseY: Word;

Function  Mouse1: boolean;
Function  Mouse2: boolean;
Function  Mouse3: boolean;

PROCEDURE SetMouse(X, Y: WORD);
FUNCTION  MouseReset: BOOLEAN;

IMPLEMENTATION

Uses Dos;

FUNCTION MouseReset: BOOLEAN; ASSEMBLER;

ASM
  MOV AX, 00h
  INT 33h
END;

PROCEDURE InitMouse; ASSEMBLER;
ASM
  MOV AX, 20h           { inicialitza }
  INT 33h

  MOV AX, 07h           { limitss horitzontals }
  MOV CX, 312
  MOV DX, 0
  INT 33h

  MOV AX, 08h           { limits verticals }
  MOV CX, 192
  MOV DX, 0
  INT 33h
END;

FUNCTION EndMouse: BOOLEAN;
VAR
  R: REGISTERS;
BEGIN
  R.AX := $1F;
  Intr($33, R);
  EndMouse := (R.AX AND $001F) = $001F;
END;


PROCEDURE SetMouse(X, Y: WORD); ASSEMBLER;

ASM
  MOV AX, 04h
  MOV CX, X
  MOV DX, Y
  INT 33h
END;

Function MouseX: Word; assembler;
asm
  mov ax,$0003
  int 33h
  mov ax,cx
end;

Function MouseY: Word; assembler;
asm
  mov ax,$0003
  int 33h
  mov ax,dx
end;

Function Mouse1: boolean;
VAR
  R: REGISTERS;
begin
  R.AX := 3;
  Intr($33, R);
  Mouse1 := (R.BX AND $01) = $01;
end;

Function Mouse2: boolean;
VAR
  R: REGISTERS;
begin
  R.AX := 3;
  Intr($33, R);
  Mouse2 := (R.BX AND $02) = $02;
end;

Function Mouse3: boolean;
VAR
  R: REGISTERS;
begin
  R.AX := 3;
  Intr($33, R);
  Mouse3 := (R.BX AND $04) = $04;
end;


END.