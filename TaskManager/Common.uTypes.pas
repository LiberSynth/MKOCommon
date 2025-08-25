unit Common.uTypes;

interface

uses
  { VCL }
  System.SysUtils;

type

  EMKOTMException = class(Exception);
  EMKOLibException = class(Exception);

  TBlob = RawByteString;  { RawByteString is too long to write everywhere. }

implementation

end.
