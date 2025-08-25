unit Common.uUtils;

interface

uses
  { VCL }
  System.SysUtils,
  { Common }
  Common.uConsts;

function CutStr(var Value: String; CutCount: Integer): Boolean; inline; overload;
function CutStr(var Value: WideString; CutCount: Integer): Boolean; inline; overload;
function ExeDir: String;

implementation

function CutStr(var Value: String; CutCount: Integer): Boolean;
var
  L: Integer;
begin

  L := Length(Value);

  Result := L >= CutCount;
  if Result then
    Value := Copy(Value, 1, L - CutCount);

end;

function CutStr(var Value: WideString; CutCount: Integer): Boolean;
var
  L: Integer;
begin

  L := Length(Value);

  Result := L >= CutCount;
  if Result then
    Value := Copy(Value, 1, L - CutCount);

end;

function ParseParams(Params: String): TArray<String>;
var
  I: Integer;
begin

  while Params.IndexOf('  ') > -1 do

    Params :=

        { Fluent Interface ;) }
        Params.
        Replace('  ', ' ', [rfReplaceAll]).
        Trim;

  Result := Params.Split([CRLF]);

  for i := Low(Result) to High(Result) do
    Result[i] := Result[i].Trim;

end;

function ExeDir: String;
begin
  Result := ExtractFileDir(ParamStr(0));
end;

end.
