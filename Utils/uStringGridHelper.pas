unit uStringGridHelper;

interface

uses
  { VCL }
  Vcl.Grids;

type

  TStringGridHelper = class helper for TStringGrid

  public

    procedure Locate(_Object: TObject; _ObjectCol: Integer);

  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Locate(_Object: TObject; _ObjectCol: Integer);
var
  i:Integer;
  TheObject: TObject;
begin

  if Assigned(_Object) then

    for i := FixedRows to RowCount - 1 do
    begin

      TheObject := Objects[_ObjectCol, i];
      if Assigned(TheObject) and (TheObject = _Object) then
      begin

        Row := i;
        Exit;

      end;

    end;

  Row := FixedRows;

end;

end.
