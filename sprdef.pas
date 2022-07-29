unit sprdef;

interface

uses typedefs;

  Procedure InitHero(var hero : Thero);


implementation

Procedure InitHero(var hero : Thero);
begin

{ quiet }
hero.state[0].numFrames := 1;
hero.state[0].Frame[0].delay := 1;
hero.state[0].Frame[0].off   := (  0) + (  0 *320);
hero.state[0].Frame[0].moveX := 0;
hero.state[0].Frame[0].moveY := 0;
hero.state[0].Frame[0].sig   := 0;

{ caminant }
hero.state[1].numFrames      := 9;
hero.state[1].Frame[0].delay := 1;
hero.state[1].Frame[0].off   := (  0) + (  0 *320);
hero.state[1].Frame[0].moveX := 0;
hero.state[1].Frame[0].moveY := 0;
hero.state[1].Frame[0].sig   := 1;

hero.state[1].Frame[1].delay := 4;
hero.state[1].Frame[1].off   := (160) + (  0 *320);
hero.state[1].Frame[1].moveX := 2;
hero.state[1].Frame[1].moveY := 0;
hero.state[1].Frame[1].sig   := 2;

hero.state[1].Frame[2].delay := 4;
hero.state[1].Frame[2].off   := ( 96) + (  0 *320);
hero.state[1].Frame[2].moveX := 2;
hero.state[1].Frame[2].moveY := 0;
hero.state[1].Frame[2].sig   := 3;

hero.state[1].Frame[3].delay := 4;
hero.state[1].Frame[3].off   := ( 64) + (  0 *320);
hero.state[1].Frame[3].moveX := 2;
hero.state[1].Frame[3].moveY := 0;
hero.state[1].Frame[3].sig   := 4;

hero.state[1].Frame[4].delay := 4;
hero.state[1].Frame[4].off   := ( 32) + (  0 *320);
hero.state[1].Frame[4].moveX := 2;
hero.state[1].Frame[4].moveY := 0;
hero.state[1].Frame[4].sig   := 5;

hero.state[1].Frame[5].delay := 4;
hero.state[1].Frame[5].off   := ( 64) + (  0 *320);
hero.state[1].Frame[5].moveX := 2;
hero.state[1].Frame[5].moveY := 0;
hero.state[1].Frame[5].sig   := 6;

hero.state[1].Frame[6].delay := 4;
hero.state[1].Frame[6].off   := ( 96) + (  0 *320);
hero.state[1].Frame[6].moveX := 2;
hero.state[1].Frame[6].moveY := 0;
hero.state[1].Frame[6].sig   := 7;

hero.state[1].Frame[7].delay := 4;
hero.state[1].Frame[7].off   := (160) + (  0 *320);
hero.state[1].Frame[7].moveX := 2;
hero.state[1].Frame[7].moveY := 0;
hero.state[1].Frame[7].sig   := 8;

hero.state[1].Frame[8].delay := 4;
hero.state[1].Frame[8].off   := (128) + (  0 *320);
hero.state[1].Frame[8].moveX := 2;
hero.state[1].Frame[8].moveY := 0;
hero.state[1].Frame[8].sig   := 1;

{ bot_curt }
hero.state[2].Frame[0].delay := 4;
hero.state[2].Frame[0].off   := (  0) + (  0 *320);
hero.state[2].Frame[0].moveX := 0;
hero.state[2].Frame[0].moveY := 0;
hero.state[2].Frame[0].sig   := 1;

hero.state[2].Frame[1].delay := 4;
hero.state[2].Frame[1].off   := (192) + (  0 *320);
hero.state[2].Frame[1].moveX := 5;
hero.state[2].Frame[1].moveY := 0;
hero.state[2].Frame[1].sig   := 2;

hero.state[2].Frame[2].delay := 4;
hero.state[2].Frame[2].off   := (224) + (  0 *320);
hero.state[2].Frame[2].moveX := 4;
hero.state[2].Frame[2].moveY := -2;
hero.state[2].Frame[2].sig   := 3;

hero.state[2].Frame[3].delay := 4;
hero.state[2].Frame[3].off   := (224) + (  0 *320);
hero.state[2].Frame[3].moveX := 3;
hero.state[2].Frame[3].moveY := -3;
hero.state[2].Frame[3].sig   := 4;

hero.state[2].Frame[4].delay := 4;
hero.state[2].Frame[4].off   := (224) + (  0 *320);
hero.state[2].Frame[4].moveX := 3;
hero.state[2].Frame[4].moveY := -1;
hero.state[2].Frame[4].sig   := 5;

hero.state[2].Frame[5].delay := 4;
hero.state[2].Frame[5].off   := (224) + (  0 *320);
hero.state[2].Frame[5].moveX := 2;
hero.state[2].Frame[5].moveY := 0;
hero.state[2].Frame[5].sig   := 6;

hero.state[2].Frame[6].delay := 4;
hero.state[2].Frame[6].off   := (224) + (  0 *320);
hero.state[2].Frame[6].moveX := 2;
hero.state[2].Frame[6].moveY := 1;
hero.state[2].Frame[6].sig   := 7;

hero.state[2].Frame[7].delay := 4;
hero.state[2].Frame[7].off   := (224) + (  0 *320);
hero.state[2].Frame[7].moveX := 3;
hero.state[2].Frame[7].moveY := 2;
hero.state[2].Frame[7].sig   := 8;

hero.state[2].Frame[8].delay := 4;
hero.state[2].Frame[8].off   := (256) + (  0 *320);
hero.state[2].Frame[8].moveX := 2;
hero.state[2].Frame[8].moveY := 2;
hero.state[2].Frame[8].sig   := 9;

hero.state[2].Frame[9].delay := 4;
hero.state[2].Frame[9].off   := (288) + (  0 *320);
hero.state[2].Frame[9].moveX := 4;
hero.state[2].Frame[9].moveY := 1;
hero.state[2].Frame[9].sig   := 10;

hero.state[2].Frame[10].delay := 4;
hero.state[2].Frame[10].off   := ( 0) + (  0 *320);
hero.state[2].Frame[10].moveX := 4;
hero.state[2].Frame[10].moveY := 0;
hero.state[2].Frame[10].sig   := 0;

{ bot_llarg }
hero.state[3].Frame[0].delay := 4;
hero.state[3].Frame[0].off   := (  0) + (  0 *320);
hero.state[3].Frame[0].moveX := 0;
hero.state[3].Frame[0].moveY := 0;
hero.state[3].Frame[0].sig   := 1;

hero.state[3].Frame[1].delay := 4;
hero.state[3].Frame[1].off   := (192) + (  0 *320);
hero.state[3].Frame[1].moveX := 6;
hero.state[3].Frame[1].moveY := 0;
hero.state[3].Frame[1].sig   := 2;

hero.state[3].Frame[2].delay := 4;
hero.state[3].Frame[2].off   := (224) + (  0 *320);
hero.state[3].Frame[2].moveX := 6;
hero.state[3].Frame[2].moveY := -2;
hero.state[3].Frame[2].sig   := 3;

hero.state[3].Frame[3].delay := 4;
hero.state[3].Frame[3].off   := (224) + (  0 *320);
hero.state[3].Frame[3].moveX := 5;
hero.state[3].Frame[3].moveY := -3;
hero.state[3].Frame[3].sig   := 4;

hero.state[3].Frame[4].delay := 4;
hero.state[3].Frame[4].off   := (224) + (  0 *320);
hero.state[3].Frame[4].moveX := 5;
hero.state[3].Frame[4].moveY := -1;
hero.state[3].Frame[4].sig   := 5;

hero.state[3].Frame[5].delay := 4;
hero.state[3].Frame[5].off   := (224) + (  0 *320);
hero.state[3].Frame[5].moveX := 5;
hero.state[3].Frame[5].moveY := 0;
hero.state[3].Frame[5].sig   := 6;

hero.state[3].Frame[6].delay := 4;
hero.state[3].Frame[6].off   := (224) + (  0 *320);
hero.state[3].Frame[6].moveX := 5;
hero.state[3].Frame[6].moveY := 1;
hero.state[3].Frame[6].sig   := 7;

hero.state[3].Frame[7].delay := 4;
hero.state[3].Frame[7].off   := (224) + (  0 *320);
hero.state[3].Frame[7].moveX := 5;
hero.state[3].Frame[7].moveY := 2;
hero.state[3].Frame[7].sig   := 8;

hero.state[3].Frame[8].delay := 4;
hero.state[3].Frame[8].off   := (256) + (  0 *320);
hero.state[3].Frame[8].moveX := 2;
hero.state[3].Frame[8].moveY := 2;
hero.state[3].Frame[8].sig   := 9;

hero.state[3].Frame[9].delay := 4;
hero.state[3].Frame[9].off   := (288) + (  0 *320);
hero.state[3].Frame[9].moveX := 4;
hero.state[3].Frame[9].moveY := 1;
hero.state[3].Frame[9].sig   := 10;

hero.state[3].Frame[10].delay := 4;
hero.state[3].Frame[10].off   := ( 0) + (  0 *320);
hero.state[3].Frame[10].moveX := 4;
hero.state[3].Frame[10].moveY := 0;
hero.state[3].Frame[10].sig   := 0;

{ caiguent }
hero.state[4].Frame[0].delay := 4;
hero.state[4].Frame[0].off   := (224) + (  0 *320);
hero.state[4].Frame[0].moveX := 0;
hero.state[4].Frame[0].moveY := 4;
hero.state[4].Frame[0].sig   := 0;

{ caiguent_avant }
hero.state[5].Frame[0].delay := 4;
hero.state[5].Frame[0].off   := (224) + (  0 *320);
hero.state[5].Frame[0].moveX := 4;
hero.state[5].Frame[0].moveY := 2;
hero.state[5].Frame[0].sig   := 1;

hero.state[5].Frame[1].delay := 4;
hero.state[5].Frame[1].off   := (224) + (  0 *320);
hero.state[5].Frame[1].moveX := 4;
hero.state[5].Frame[1].moveY := 3;
hero.state[5].Frame[1].sig   := 2;

hero.state[5].Frame[2].delay := 4;
hero.state[5].Frame[2].off   := (224) + (  0 *320);
hero.state[5].Frame[2].moveX := 2;
hero.state[5].Frame[2].moveY := 5;
hero.state[5].Frame[2].sig   := 3;

hero.state[5].Frame[3].delay := 4;
hero.state[5].Frame[3].off   := (224) + (  0 *320);
hero.state[5].Frame[3].moveX := 2;
hero.state[5].Frame[3].moveY := 8;
hero.state[5].Frame[3].sig   := 3;

{ bot_amunt }
hero.state[6].Frame[0].delay := 4;
hero.state[6].Frame[0].off   := (  0) + (  0 *320);
hero.state[6].Frame[0].moveX := 0;
hero.state[6].Frame[0].moveY := 0;
hero.state[6].Frame[0].sig   := 1;

hero.state[6].Frame[1].delay := 6;
hero.state[6].Frame[1].off   := (  0) + ( 64 *320);
hero.state[6].Frame[1].moveX := 0;
hero.state[6].Frame[1].moveY := 0;
hero.state[6].Frame[1].sig   := 2;

hero.state[6].Frame[2].delay := 8;
hero.state[6].Frame[2].off   := (192) + (  0 *320);
hero.state[6].Frame[2].moveX := 0;
hero.state[6].Frame[2].moveY := 0;
hero.state[6].Frame[2].sig   := 3;

hero.state[6].Frame[3].delay := 4;
hero.state[6].Frame[3].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[3].moveX := 0;
hero.state[6].Frame[3].moveY := -4;
hero.state[6].Frame[3].sig   := 4;

hero.state[6].Frame[4].delay := 4;
hero.state[6].Frame[4].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[4].moveX := 0;
hero.state[6].Frame[4].moveY := -2;
hero.state[6].Frame[4].sig   := 5;

hero.state[6].Frame[5].delay := 4;
hero.state[6].Frame[5].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[5].moveX := 0;
hero.state[6].Frame[5].moveY := -2;
hero.state[6].Frame[5].sig   := 6;

hero.state[6].Frame[6].delay := 4;
hero.state[6].Frame[6].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[6].moveX := 0;
hero.state[6].Frame[6].moveY := 2;
hero.state[6].Frame[6].sig   := 7;

hero.state[6].Frame[7].delay := 4;
hero.state[6].Frame[7].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[7].moveX := 0;
hero.state[6].Frame[7].moveY := 2;
hero.state[6].Frame[7].sig   := 8;

hero.state[6].Frame[8].delay := 4;
hero.state[6].Frame[8].off   := ( 32) + ( 64 *320);
hero.state[6].Frame[8].moveX := 0;
hero.state[6].Frame[8].moveY := 4;
hero.state[6].Frame[8].sig   := 0;

{ penjat }
hero.state[7].Frame[0].delay := 4;
hero.state[7].Frame[0].off   := ( 32) + ( 64 *320);
hero.state[7].Frame[0].moveX := 0;
hero.state[7].Frame[0].moveY := 0;
hero.state[7].Frame[0].sig   := 0;

{ pujant }
hero.state[8].Frame[0].delay := 4;
hero.state[8].Frame[0].off   := ( 32) + ( 64 *320);
hero.state[8].Frame[0].moveX := 0;
hero.state[8].Frame[0].moveY := 0;
hero.state[8].Frame[0].sig   := 1;

hero.state[8].Frame[1].delay := 8;
hero.state[8].Frame[1].off   := ( 64) + ( 64 *320);
hero.state[8].Frame[1].moveX := 1;
hero.state[8].Frame[1].moveY := -6;
hero.state[8].Frame[1].sig   := 2;

hero.state[8].Frame[2].delay := 8;
hero.state[8].Frame[2].off   := ( 96) + ( 64 *320);
hero.state[8].Frame[2].moveX := 3;
hero.state[8].Frame[2].moveY := -6;
hero.state[8].Frame[2].sig   := 3;

hero.state[8].Frame[3].delay := 8;
hero.state[8].Frame[3].off   := (128) + ( 64 *320);
hero.state[8].Frame[3].moveX := 2;
hero.state[8].Frame[3].moveY := -6;
hero.state[8].Frame[3].sig   := 0;

{ penjat_bal}
hero.state[9].Frame[0].delay := 1;
hero.state[9].Frame[0].off   := ( 32) + ( 64 *320);
hero.state[9].Frame[0].moveX := 0;
hero.state[9].Frame[0].moveY := 0;
hero.state[9].Frame[0].sig   := 1;

hero.state[9].Frame[1].delay := 8;
hero.state[9].Frame[1].off   := (192) + ( 64 *320);
hero.state[9].Frame[1].moveX := 0;
hero.state[9].Frame[1].moveY := 0;
hero.state[9].Frame[1].sig   := 2;

hero.state[9].Frame[2].delay := 4;
hero.state[9].Frame[2].off   := ( 32) + ( 64 *320);
hero.state[9].Frame[2].moveX := 0;
hero.state[9].Frame[2].moveY := 0;
hero.state[9].Frame[2].sig   := 3;

hero.state[9].Frame[3].delay := 6;
hero.state[9].Frame[3].off   := (160) + ( 64 *320);
hero.state[9].Frame[3].moveX := 0;
hero.state[9].Frame[3].moveY := 0;
hero.state[9].Frame[3].sig   := 4;

hero.state[9].Frame[4].delay := 4;
hero.state[9].Frame[4].off   := ( 32) + ( 64 *320);
hero.state[9].Frame[4].moveX := 0;
hero.state[9].Frame[4].moveY := 0;
hero.state[9].Frame[4].sig   := 5;

hero.state[9].Frame[5].delay := 4;
hero.state[9].Frame[5].off   := (192) + ( 64 *320);
hero.state[9].Frame[5].moveX := 0;
hero.state[9].Frame[5].moveY := 0;
hero.state[9].Frame[5].sig   := 6;

hero.state[9].Frame[6].delay := 4;
hero.state[9].Frame[6].off   := ( 32) + ( 64 *320);
hero.state[9].Frame[6].moveX := 0;
hero.state[9].Frame[6].moveY := 0;
hero.state[9].Frame[6].sig   := 6;

{ mort }
hero.state[10].Frame[0].delay := 4;
hero.state[10].Frame[0].off   := (224) + ( 64 *320);
hero.state[10].Frame[0].moveX := 0;
hero.state[10].Frame[0].moveY := 0;
hero.state[10].Frame[0].sig   := 0;


hero.x := 36;
hero.y := 104;
hero.o := 0;
hero.a := 0;

hero.actState := 0;
hero.actFrame := 0;
end;

end.
