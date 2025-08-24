unit uFileExplorer;

interface

uses
  { VCL }
  System.SysUtils;

type

  TFileProc = reference to procedure(const FileName: String; MaskMatches: Boolean; var Terminated: Boolean);

procedure ExploreFiles(const Path, Masks: String; Recursive: Boolean; Handler: TFileProc); overload;
procedure ExploreFiles(const Path, Masks: String; Handler: TFileProc); overload;
procedure ExploreFiles(const Path: String; Recursive: Boolean; Handler: TFileProc); overload;
procedure ExploreFiles(const Path: String; Handler: TFileProc); overload;

implementation

type

  TFileExplorer = class

  strict private

    FPath: String;
    FMasks: String;
    FRecursive: Boolean;
    FInitialized: Boolean;
    FTerminated: Boolean;
    FMaskList: TArray<TArray<String>>;

    procedure Init;

    function CheckMasks(const _Value: String): Boolean;
    function CheckMask(const _Value: String; const _Mask: TArray<String>): Boolean;
    function CheckSingleMask(const _Value, _Mask: String): Boolean;
    procedure RaiseInvalidMaskError(const _Mask: String);

    property Terminated: Boolean read FTerminated;
    property Initialized: Boolean read FInitialized;
    property MaskList: TArray<TArray<String>> read FMaskList;

  public

    procedure Run(_Handler: TFileProc);

    property Path: String read FPath write FPath;
    property Masks: String read FMasks write FMasks;
    property Recursive: Boolean read FRecursive write FRecursive;

  end;

procedure ExploreFiles(const Path, Masks: String; Recursive: Boolean; Handler: TFileProc);
var
  FileExplorer: TFileExplorer;
begin

  FileExplorer := TFileExplorer.Create;
  try

    FileExplorer.Path := Path;
    FileExplorer.Masks := Masks;
    FileExplorer.Recursive := Recursive;
    FileExplorer.Run(Handler);

  finally
    FileExplorer.Free;
  end;

end;

procedure ExploreFiles(const Path, Masks: String; Handler: TFileProc);
begin
  ExploreFiles(Path, Masks, False, Handler);
end;

procedure ExploreFiles(const Path: String; Recursive: Boolean; Handler: TFileProc);
begin
  ExploreFiles(Path, Recursive, Handler);
end;

procedure ExploreFiles(const Path: String; Handler: TFileProc);
begin
  ExploreFiles(Path, '', False, Handler);
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

procedure TFileExplorer.Init;
var
  SA: TArray<String>;
  i, L: Integer;
begin

  if not Initialized then
  begin

    {TODO 2 -oVasilevSM : Здесь нужен парсер. И, создать архитектуру для масок, типизованный рекорд, где может быть одна часть и две итд. }
    SA := Masks.Split(['|']);
    L := Length(SA);
    SetLength(FMaskList, L);

    for i := 0 to L - 1 do
    begin

      MaskList[i] := SA[i].Split(['.']);

      if Length(MaskList[i]) <> 2 then
        RaiseInvalidMaskError(SA[i]);

    end;

    FInitialized := True;

  end;

end;

function TFileExplorer.CheckMask(const _Value: String; const _Mask: TArray<String>): Boolean;
var
  NameMask, ExtMask: String;
  PointPos: Integer;
  FileName, FileExt: String;
begin

  NameMask := _Mask[0];
  ExtMask := _Mask[1];

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
begin

  if Length(MaskList) = 0 then
    Exit(True);

  for SA in MaskList do
    if CheckMask(_Value, SA) then
      Exit(True);

  Result := False;

end;

procedure TFileExplorer.Run(_Handler: TFileProc);
var
  SR: TSearchRec;
  TempPath: String;
begin

  Init;

  if FindFirst(Path + '\*.*', faAnyFile, SR) = 0 then

    try

      repeat

        if

            (SR.Name <> '..') and
            (SR.Name <> '.')

        then

          if SR.Attr and faDirectory <> 0 then
          begin

            if Recursive then
            begin

              TempPath := Path;
              Path := Format('%s\%s', [Path, SR.Name]);
              try

                Run(_Handler);

              finally
                Path := TempPath;
              end;

            end;

          end
          else

            _Handler(Format('%s\%s', [Path, SR.Name]), CheckMasks(SR.Name), FTerminated);

      until Terminated or (FindNext(SR) <> 0);

    finally
      FindClose(SR);
    end;

end;

end.
