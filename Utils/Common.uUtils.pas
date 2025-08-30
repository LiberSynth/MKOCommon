unit Common.uUtils;

interface

uses
  { VCL }
  System.SysUtils, Winapi.Windows,
  { Common }
  Common.uConsts;

function CutStr(var Value: String; CutCount: Integer): Boolean; inline; overload;
function CutStr(var Value: WideString; CutCount: Integer): Boolean; inline; overload;
function ExeDir: String;
function OEMToUnicode(const Source: TArray<Byte>; Length: Integer): String;

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

function OEMToUnicode(const Source: TArray<Byte>; Length: Integer): String; overload;
var
  BuffA: AnsiChar;
  BuffW: String;
  i: Integer;
begin

  Result := '';
  SetLength(BuffW, 1);

  for i := 0 to Length - 1 do
  begin

    if Source[i] = 0 then
      Break;

    if Ord(Source[i]) >= 32 then
    begin

      BuffA := AnsiChar(Source[i]);
      OemToCharBuff(PAnsiChar(BuffA), @BuffW[1], 1);
      Result := Result + BuffW;

    end
    else Result := Result + Char(Source[i]);

  end;

end;

end.
