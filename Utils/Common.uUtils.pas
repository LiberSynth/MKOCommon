unit Common.uUtils;

interface

uses
  { VCL }
  System.SysUtils,
  { Common }
  Common.uConsts;

function CutStr(var Value: String; CutCount: Integer): Boolean; inline; overload;
function CutStr(var Value: WideString; CutCount: Integer): Boolean; inline; overload;
function ParseParams(Params: String): TArray<String>;
function ReduceParams(const Params: TArray<String>): String;

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

function ReduceParams(const Params: TArray<String>): String;

  function _Reduce(const _Value: String): String;
  begin

    if _Value.IndexOf(' ') > -1 then
      Result := Format('"%s"', [_Value])
    else
      Result := _Value;

  end;

var
  S: String;
begin

  Result := '';

  for S in Params do
    Result := Format('%s%s ', [Result, _Reduce(S)]);

  CutStr(Result, 1);

end;

end.
