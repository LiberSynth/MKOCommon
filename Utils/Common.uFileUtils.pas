unit Common.uFileUtils;

interface

uses
  { VCL }
  System.SysUtils, System.Classes,
  { Common }
  Common.uConsts, Common.uTypes;

function FileToBLOB(const FileName: String): TBlob;
procedure StrToFile(const FileName, Value: String; Force: Boolean = True);
function UniqueFileName(const Desirable: String): String;

implementation

function FileToBLOB(const FileName: String): TBlob;
begin

	with TFileStream.Create(FileName, fmOpenRead) do

		try

      SetLength(Result, 0);
			SetLength(Result, Size);
			Read(Pointer(Result)^, Length(Result));

		finally
			Free;
		end;

end;

procedure StrToFile(const FileName, Value: String; Force: Boolean);
var
  Mode: Word;
  Blob: TBlob;
begin

  Mode := fmOpenWrite or fmShareDenyWrite;
  if Force then
  begin

    ForceDirectories(ExtractFileDir(FileName));
    if not FileExists(FileName) then
       Mode := Mode or fmCreate;

  end;

  with TFileStream.Create(FileName, Mode) do

    try

      Blob := BOM_UTF8 + UTF8Encode(Value);
      Size := Length(Blob);
      Position := 0;

      Write(Pointer(Blob)^, Length(Blob));

    finally
      Free;
    end;

end;

function UniqueFileName(const Desirable: String): String;
const
  SC_FORMAT = '%s (%d)%s';
var
  I, P: Integer;
  FileName, Extension: String;
begin

  P := Desirable.LastDelimiter('.');
  FileName := Copy(Desirable, 1, P);
  Extension := Copy(Desirable, P + 1, Length(Desirable));
  I := 0;

  Result := Desirable;

  while FileExists(Result) do
  begin

    Inc(I);
    Result := Format(SC_FORMAT, [FileName, I, Extension]);

  end;

end;

end.
