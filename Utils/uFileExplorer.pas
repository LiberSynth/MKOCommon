unit uFileExplorer;

interface

uses
  { VCL }
  System.SysUtils;

type

  TFileProc = reference to procedure(const FileName: String);

  TFileExplorer = class

  strict private

    FPath: String;
    FMasks: String;

    function CheckMasks(const _Value: String): Boolean;
    function CheckMask(const _Value, _Mask: String): Boolean;
    function CheckSingleMask(const _Value, _Mask: String): Boolean;
    procedure RaiseInvalidMaskError(const _Mask: String);

  public

    procedure Run(_Handler: TFileProc);

    property Path: String read FPath write FPath;
    property Masks: String read FMasks write FMasks;

  end;

procedure ExploreFiles(const Path, Masks: String; Handler: TFileProc); overload;
procedure ExploreFiles(const Path: String; Handler: TFileProc); overload;

implementation

procedure ExploreFiles(const Path, Masks: String; Handler: TFileProc);
var
  FileExplorer: TFileExplorer;
begin

  FileExplorer := TFileExplorer.Create;
  try

    FileExplorer.Path := Path;
    FileExplorer.Masks := Masks;
    FileExplorer.Run(Handler);

  finally
    FileExplorer.Free;
  end;

end;

procedure ExploreFiles(const Path: String; Handler: TFileProc);
begin
  ExploreFiles(Path, '', Handler);
end;

{ TFileExplorer }

procedure TFileExplorer.RaiseInvalidMaskError(const _Mask: String);
begin
  raise Exception.CreateFmt('File mask ''%s'' is not valid.', [_Mask]);
end;

function TFileExplorer.CheckSingleMask(const _Value, _Mask: String): Boolean;
var
  AsterikPos, LLenght, RLength, VLength: Integer;
  LeftMask, RightMask: String;
begin

  if _Mask.CountChar('*') > 1 then
    RaiseInvalidMaskError(_Mask);

  if _Mask = '*' then
    Exit(True);

  AsterikPos := Pos('*', _Mask);
  if AsterikPos = 0 then
    Exit(AnsiSameText(_Value, _Mask));

  LeftMask := Copy(_Mask, 1, AsterikPos - 1);
  RightMask := _Mask.Substring(AsterikPos);

  LLenght := LeftMask.Length;
  RLength := RightMask.Length;
  VLength := _Value.Length;

  Result :=

      ((LLenght = 0) or AnsiSameText(LeftMask, Copy(_Value, 1, LLenght))) and
      ((RLength = 0) or ((VLength >= RLength) and AnsiSameText(RightMask, _Value.Substring(VLength - RLength))));

end;

function TFileExplorer.CheckMask(const _Value, _Mask: String): Boolean;
var
  SA: TArray<String>;
  NameMask, ExtMask: String;
  PointPos: Integer;
  FileName, FileExt: String;
begin

  SA := _Mask.Split(['.']);

  if Length(SA) <> 2 then
    RaiseInvalidMaskError(_Mask);

  NameMask := SA[0];
  ExtMask := SA[1];

  PointPos := _Value.LastIndexOf('.');

  if PointPos = 0 then
  begin

    FileName := _Value;
    FileExt := '';

  end
  else
  begin

    FileName := Copy(_Value, 1, PointPos);
    FileExt := _Value.Substring(PointPos + 1);

  end;

  Result :=

    CheckSingleMask(FileName, NameMask) and
    CheckSingleMask(FileExt, ExtMask);

end;

function TFileExplorer.CheckMasks(const _Value: String): Boolean;
var
  SA: TArray<String>;
  S: String;
begin

  if Length(Masks) = 0 then
    Exit(True);

  SA := Masks.Split(['|']);
  for S in SA do
    if CheckMask(_Value, S) then
      Exit(True);

  Result := False;

end;

procedure TFileExplorer.Run(_Handler: TFileProc);
var
  SR: TSearchRec;
begin

  if FindFirst(Path + '\*.*', faAnyFile, SR) = 0 then

    try

      repeat

        if

            (SR.Name <> '..') and
            (SR.Name <> '.') and
            CheckMasks(SR.Name)

        then _Handler(Format('%s\%s', [Path, SR.Name]))

      until FindNext(SR) <> 0;

    finally
      FindClose(SR);
    end;

end;

end.
