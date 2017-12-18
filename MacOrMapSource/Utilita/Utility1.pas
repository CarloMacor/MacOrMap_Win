unit Utility1;

interface

uses Vcl.Menus;

function FindItemByName(aMenuItem: TMenuItem; ItemName: string): TMenuItem;


implementation


var
  //global vars
  StringValue: string;



procedure BypassMenuItem(Func: Pointer; Source: TMenuItem);
var
  I, J: Integer;
  MenuSize: Integer;
  Done: Boolean;

function ByPass(var I: Integer; aMenuItem: TMenuItem; AFunc: Pointer): Boolean;
  var
    Item: TMenuItem;
  begin
    if aMenuItem = nil then Exit;
    Result := False;

    while not Result and (I < aMenuItem.Count) do
    begin
      Item := aMenuItem[I];
      asm
                MOV     EAX,Item
                MOV     EDX,[EBP+8]
                PUSH    DWORD PTR [EDX]
                CALL    DWORD PTR AFunc
                ADD     ESP,4
                MOV     Result,AL
      end;
      Inc(I);
    end;
  end;
begin
  I        := 0;
  J        := 0;
  MenuSize := 0;
  if Source <> nil then MenuSize := Source.Count;
  Done := False;
  while not Done and (I < MenuSize) do
  begin
    Done := Bypass(I, Source, Func);
    while (I < MenuSize) do Inc(I);
  end;
end;

//Finds Item.Name = ItemName  in the aMenuItem.Items
// Returns found item or nil.
function FindItemByName(aMenuItem: TMenuItem; ItemName: string): TMenuItem;
  // As variant: ItemTag:Integer; instead ItemName
 var FoundItem : TMenuItem;
  function Find(Item: TMenuItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if (StringValue = Item.Name) then
    // As variant: if (IntegerValue = Item.Tag)  then
    begin
      FoundItem := Item;
      Result := True;
      Exit;
    end
    else
      for I := 0 to Item.Count - 1 do
        if Find(Item[I]) then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  FoundItem   := nil;
  StringValue := ItemName; // Assigns Find argument to global variable.
  // As variant: IntegerValue := ItemTag;

  BypassMenuItem(@Find, aMenuItem);
  Result := FoundItem;
end;



end.
