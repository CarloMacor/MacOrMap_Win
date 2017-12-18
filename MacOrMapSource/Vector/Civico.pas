unit Civico;

interface



uses windows,System.classes,vettoriale,GR32, GR32_Image, GR32_Layers, sysutils,FMX.Dialogs;

type
 TCivico = class(TVettoriale)
    x1c,y1c : Real;
    x2c,y2c : Real;
    x3c,y3c : Real;
    txtciv : String;
    nomestrada : String;
    altezza : real;
    angolo  : real;
   Constructor Create;                                   virtual;
   Destructor  Done;                                     virtual;
   procedure   Disegna            (HHDC : TImage32);                                   override;
   procedure   DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer); override;
   procedure   initCivico         (_x1,_y1,_x2,_y2,_x3,_y3 : Real; _txtciv:String );
   procedure   faiLimiti          ;                                                    override;
   Function    inSchermo: Boolean;                                                     override;
   procedure   seleziona_conPt    (x1, y1 : Real; _LSelezionati : Tlist);              override;
   function    selezionami         (xc,yc : real): Integer;
   Procedure   salvavettorialeMacMap (St : TMemoryStream);                             override;
   Procedure   aprivettorialeMacMap  (St : TMemoryStream);                             override;
   function    susestesso : Boolean;
 end;

 var CivicoinEdit : TCivico;
     modoeditcivico  : Integer;
     stradaAttualeCivico : String;

implementation

uses varbase, funzioni;

 constructor TCivico.Create;
 begin
   Inherited Create;
    tipo := PCivico;
    altezza := 200;
    angolo := 0.0;
    txtciv:='';
    nomestrada := '';
 end;

Destructor  TCivico.Done;
 begin
   Inherited Done;
 end;


procedure   TCivico.Disegna(HHDC : TImage32);
var xp1, yp1 : single;
    xp2, yp2 : single;
    xp3, yp3 : single;
    hdc : Thandle;
     ht : Integer;
begin
 hdc:= HHDC.Bitmap.Canvas.Handle;
 if b_erased then exit;
 if Not(inSchermo) then exit;
 with HHDC.Bitmap do
  begin
  	xp1 :=  Xinschermo(x1c); 	yp1 :=  Yinschermo(y1c);
    MoveToEx(Hdc, round(xp1-(_piano.dimpunto)), round(yp1), nil);    LineTo(HDC, round(xp1+(_piano.dimpunto+1)), round(yp1));
    MoveToEx(Hdc, round(xp1), round(yp1-(_piano.dimpunto)), nil);    LineTo(HDC, round(xp1), round(yp1+(_piano.dimpunto+1)));

  	xp2 :=  Xinschermo(x2c); 	yp2 :=  Yinschermo(y2c);
    MoveToEx(Hdc, round(xp2-(_piano.dimpunto)), round(yp2), nil);    LineTo(HDC, round(xp2+(_piano.dimpunto+1)), round(yp2));
    MoveToEx(Hdc, round(xp2), round(yp2-(_piano.dimpunto)), nil);    LineTo(HDC, round(xp2), round(yp2+(_piano.dimpunto+1)));

  	xp3 :=  Xinschermo(x3c); 	yp3 :=  Yinschermo(y3c);
    MoveToEx(Hdc, round(xp3-(_piano.dimpunto)), round(yp3), nil);    LineTo(HDC, round(xp3+(_piano.dimpunto+1)), round(yp3));
    MoveToEx(Hdc, round(xp3), round(yp3-(_piano.dimpunto)), nil);    LineTo(HDC, round(xp3), round(yp3+(_piano.dimpunto+1)));


  ht := round((altezza/(scalavista* 80)));
  if ht>=5 then begin
   HHDC.Bitmap.Canvas.Font.Color := RGB(0,0,0) ;
   HHDC.Bitmap.Canvas.Font.Height:=ht;
   HHDC.Bitmap.Canvas.Font.Orientation := round(angolo*1800/pi);
   HHDC.Bitmap.Canvas.textout(round(xp2),round(yp2),txtciv);
  end;

    MoveToEx(Hdc, round(xp1), round(yp1), nil);
    LineTo(HDC, round(xp2), round(yp2));
    LineTo(HDC, round(xp3), round(yp3));


  end;
end;

procedure  TCivico.DisegnaConColori   (HHDC : TImage32; Color32Bordo   : TColor32; Color32Dentro  : TColor32;spess:Integer);
var     xp2, yp2 : single;
    ht : Integer;
begin
  if Not(inSchermo) then exit;
 	xp2 :=  Xinschermo(x2c); 	yp2 :=  Yinschermo(y2c);


  HHDC.Bitmap.Canvas.Pen.Color:=RGB(255,0,0) ;
  disegna(HHDC);
  ht := round((altezza/(scalavista* 80)));
  if ht>=5 then begin
  HHDC.Bitmap.Canvas.Font.Color:=RGB(255,0,0) ;
   HHDC.Bitmap.Canvas.Font.Height:=ht;
   HHDC.Bitmap.Canvas.Font.Orientation := round(angolo*1800/pi);
   HHDC.Bitmap.Canvas.textout(round(xp2),round(yp2),txtciv);
  end;


end;



procedure   TCivico.initCivico            (_x1,_y1,_x2,_y2,_x3,_y3 : Real; _txtciv:String );
begin
 x1c := _x1;     y1c := _y1;        x2c := _x2;     y2c := _y2;     x3c := _x3;     y3c := _y3;  txtciv :=_txtciv;
 failimiti;
end;

procedure   TCivico.faiLimiti ;
begin
	limx1 := x1c ;	limx2 := x1c ;	limy1 := y1c ;	limy2 := y1c ;
  if x2c> limx2 then limx2:= x2c;  if x3c> limx2 then limx2:= x3c;
  if x2c< limx1 then limx1:= x2c;  if x3c< limx1 then limx1:= x3c;
  if y2c> limy2 then limy2:= y2c;  if y3c> limy2 then limy2:= y3c;
  if y2c< limy1 then limy1:= y2c;  if y3c< limy1 then limy1:= y3c;

end;

Function    TCivico.inSchermo: Boolean;
var resulta : Boolean;
    x1,y1 : Single;
begin
 resulta:= true;
  x1 := Xinschermo(limx2); if x1 <0 then resulta :=false;
  y1 := Yinschermo(limy1); if y1 <0 then resulta :=false;
  x1 := Xinschermo(limx1); if x1 >Wschermo then resulta :=false;
  y1 := Yinschermo(limy2); if y1 >Hschermo then resulta :=false;
 result := resulta;
end;


procedure   TCivico.seleziona_conPt    (x1,y1 : Real; _LSelezionati : Tlist);
var off : real;
  	locres : Boolean;
  	dd, dx,dy , xsn,ysn: real;
begin
 locres := false;
 off := give_offsetmirino;

  	dd :=  distasegfunz(x1c ,y1c,x2c,y2c, x1 , y1 );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (x1c , y1c , x2c , y2c , x1 , y1,xsn,ysn )) then begin locres:=true;  end
  			else begin
  				dx :=  abs(x1-x1c); 	dy := abs(y1-y1c);
  				if ((dx<off) and (dy<off)) then begin locres:=true;  end;
  				dx :=  abs(x1-x2c); 	dy := abs(y1-y2c);
  				if ((dx<off) and (dy<off)) then begin locres:=true;  end;
        end;
     end;

  	dd :=  distasegfunz(x2c ,y2c,x3c,y3c, x1 , y1 );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (x2c ,y2c ,x3c ,y3c , x1 , y1,xsn,ysn )) then begin locres:=true;  end
  			else begin
  				dx :=  abs(x1-x2c); 	dy := abs(y1-y2c);
  				if ((dx<off) and (dy<off)) then begin locres:=true;  end;
  				dx :=  abs(x1-x3c); 	dy := abs(y1-y3c);
  				if ((dx<off) and (dy<off)) then begin locres:=true;  end;
        end;
     end;

 	if (locres) then _LSelezionati.add(self);
end;

function   TCivico.selezionami         (xc,yc : real): Integer;
var off : real;
  	dd, dx,dy , xsn,ysn: real;
    d1,d2 : Real;
    locres : Integer;
    par2 : real;
begin
 locres :=0;
 par2 :=2.0;
 off := give_offsetmirino;
  	dd :=  distasegfunz(x1c ,y1c,x2c,y2c, xc , yc );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (x1c , y1c , x2c , y2c , xc , yc,xsn,ysn )) then
       begin
        d1 := distsemplicefunz(x1c,y1c,xc,yc);
        d2 := distsemplicefunz(x2c,y2c,xc,yc);
        if d1<d2 then locres:=1 else locres:=2;
       end
  			else begin
  				dx :=  abs(xc-x1c); 	dy := abs(yc-y1c);
  				if ((dx<off) and (dy<off)) then begin  locres :=1;  end;
  				dx :=  abs(xc-x2c); 	dy := abs(yc-y2c);
  				if ((dx<off) and (dy<off)) then
           begin
            if ((x1c<>x2c) and (y1c<>y2c)) then locres :=4 else locres :=2;
           end;
        end;
     end;

  	dd :=  distasegfunz(x2c ,y2c,x3c,y3c, xc , yc );
 		if (dd<off) then
     begin
  	  if (OrtoInterno (x2c , y2c , x3c, y3c , xc , yc,xsn,ysn )) then
       begin
        d1 := distsemplicefunz(x2c,y2c,xc,yc);
        d2 := distsemplicefunz(x3c,y3c,xc,yc);
        if d1<d2 then locres:=2 else locres:=3;
       end
  			else begin
  				dx :=  abs(xc-x2c); 	dy := abs(yc-y2c);
  				if ((dx<off) and (dy<off)) then
           begin
            if ((x3c<>x2c) and (y3c<>y2c)) then locres :=4 else locres :=2;
           end;
  				dx :=  abs(xc-x3c); 	dy := abs(yc-y3c);
  				if ((dx<off) and (dy<off)) then begin locres :=3; end;
        end;
     end;

    dx :=  abs(xc-x2c); 	dy := abs(yc-y2c);
  	if ((dx<(off*par2)) and (dy<(off*par2))) then
      begin
       if ( ((x1c<>x2c) and (y1c<>y2c)) and  ((x1c<>x3c) and (y1c<>y3c)) ) then locres :=4;
      end;


 result := locres;
end;


Procedure   TCivico.salvavettorialeMacMap   (St : TMemoryStream);
var ll,k : Integer;
    cc : char;
begin
  Inherited salvavettorialeMacMap(st);
	st.Write(x1c, sizeof(x1c));	st.Write(y1c, sizeof(y1c));
	st.Write(x2c, sizeof(x2c));	st.Write(y2c, sizeof(y2c));
	st.Write(x3c, sizeof(x3c));	st.Write(y3c, sizeof(y3c));
	st.Write(altezza, sizeof(altezza));
  st.Write(angolo, sizeof(angolo));

  ll := length(txtciv); 	st.Write(ll , sizeof(ll));
  for k:=1 to ll do  begin cc := txtciv[k];	st.Write(cc , sizeof(cc)); end;

  ll := length(nomestrada); 	st.Write(ll , sizeof(ll));
  for k:=1 to ll do  begin cc := nomestrada[k];	st.Write(cc , sizeof(cc)); end;

end;


Procedure   TCivico.aprivettorialeMacMap    (St : TMemoryStream);
var ll , k: Integer;
    cc : char;
begin
  Inherited aprivettorialeMacMap(st);
	st.Read(x1c, sizeof(x1c));	st.Read(y1c, sizeof(y1c));
	st.Read(x2c, sizeof(x2c));	st.Read(y2c, sizeof(y2c));
	st.Read(x3c, sizeof(x3c));	st.Read(y3c, sizeof(y3c));
  st.Read(altezza, sizeof(altezza));
  st.Read(angolo, sizeof(angolo));

 	st.Read(ll      , sizeof(ll));
  for k:=1 to ll do  begin st.Read(cc , sizeof(cc)); txtciv:= txtciv+cc; end;

 	st.Read(ll      , sizeof(ll));
  for k:=1 to ll do  begin st.Read(cc , sizeof(cc)); nomestrada:= nomestrada+cc; end;


end;

function    TCivico.susestesso : Boolean;
var risulta : Boolean;
begin
 risulta := false;
 if ((x1c=x2c) and (x1c=x3c) and  (y1c=y2c) and  (y1c=y3c) ) then risulta := true;

 result := risulta;
end;




end.
