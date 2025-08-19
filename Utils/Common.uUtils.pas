unit Common.uUtils;

interface

uses
  { VCL }
  System.SysUtils,
  { Common }
  Common.uConsts;

function ParseParams(const _Params: String): TArray<String>;

implementation

function ParseParams(const _Params: String): TArray<String>;
begin
  Result := _Params.Split([' ', CRLF, CR, LF]);
end;

end.
