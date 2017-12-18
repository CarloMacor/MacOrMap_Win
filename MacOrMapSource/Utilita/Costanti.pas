unit Costanti;

interface

const
   minRotRasGauge = -600;
   maxRotRasGauge =  600;

var
    _sin4  : array[0..3] of real;
    _sin8  : array[0..7] of real;
    _sin16 : array[0..15] of real;
    _sin32 : array[0..31] of real;
    _sin64 : array[0..65] of real;

    _cos4  : array[0..3] of real;
    _cos8  : array[0..7] of real;
    _cos16 : array[0..15] of real;
    _cos32 : array[0..31] of real;
    _cos64 : array[0..65] of real;

procedure InizializzaAngolifissi;

implementation

procedure InizializzaAngolifissi;
var k : integer;
    angolo : Real;
begin
  angolo := 0.0;
  for k:=0 to 3  do begin _sin4[k]:= sin(angolo);  _cos4[k]:= cos(angolo);    angolo := angolo + Pi / 2;  end;
  angolo := 0.0;
  for k:=0 to 7  do begin _sin8[k]:= sin(angolo);  _cos8[k]:= cos(angolo);    angolo := angolo + Pi / 4;  end;
  angolo := 0.0;
  for k:=0 to 15 do begin _sin16[k]:= sin(angolo); _cos16[k]:= cos(angolo);   angolo := angolo + Pi / 8;  end;
  angolo := 0.0;
  for k:=0 to 31 do begin _sin32[k]:= sin(angolo); _cos32[k]:= cos(angolo);   angolo := angolo + Pi / 16;  end;
  angolo := 0.0;
  for k:=0 to 64 do begin _sin64[k]:= sin(angolo); _cos64[k]:= cos(angolo);   angolo := angolo + Pi / 32;  end;


end;





end.
