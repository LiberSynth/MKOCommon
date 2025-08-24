unit uTypes;

interface

uses
  { VCL }
  System.SysUtils;

type

  EMKOTMException = class(Exception);
  EMKOLibException = class(Exception);

  TBLOB = RawByteString;  { RawByteString is too long to write everywhere. }

implementation

end.
