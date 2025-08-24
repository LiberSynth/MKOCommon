unit uFileUtils;

interface

uses
  { VCL }
  System.SysUtils, System.Classes,
  { Common }
  uTypes;

function FileToBLOB(FileName: String): TBLOB;

implementation

function FileToBLOB(FileName: String): TBLOB;
begin

	with TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite) do

		try

      SetLength(Result, 0);
			SetLength(Result, Size);
			Read(Pointer(Result)^, Length(Result));

		finally
			Free;
		end;

end;

end.
