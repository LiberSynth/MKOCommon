unit uStringGridHelper;

interface

uses
  { VCL }
  Vcl.Grids, Vcl.Forms, System.Types;

type

  {TODO 4 -oVasilevSM : В итоге, Locate не понадобился, так что и хэлпер не нужен. }
  TStringGridHelper = class helper for TStringGrid

  public

    procedure Locate(_Object: TObject; _ObjectCol: Integer = 0);
    
  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Locate(_Object: TObject; _ObjectCol: Integer);
var
  i:Integer;
begin

  if Assigned(_Object) then

    for i := FixedRows to RowCount - 1 do

      if Objects[_ObjectCol, i] = _Object then
      begin

        Row := i;
        Exit;

      end;

  Row := FixedRows;

end;

end.
