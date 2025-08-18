unit uCustomTasks;

interface

uses
  { VCL }
  System.SysUtils,
  { Common }
  uInterfaces, Common.uConsts;

type

  TCustomMKOTask = class(TInterfacedObject, IMKOTask)

  strict private

    function ParseParams(const _Params: String): TArray<String>;

  protected

    { IMKOTask }
    function GetName: WideString; virtual; safecall; abstract;
    function GetCaption: WideString; virtual; safecall; abstract;
    function GetDescription: WideString; virtual; safecall; abstract;
    function GetParamsHelpText: WideString; virtual; safecall; abstract;
    procedure ValidateParams(const _Params: WideString); overload; virtual; safecall;
    procedure Start(const _Params: WideString); overload; virtual; safecall;
    procedure Cancel; virtual; safecall; abstract;

    procedure ValidateParams(const _Params: TArray<String>); overload; virtual;
    procedure Start(const _Params: TArray<String>); overload; virtual;

  end;

implementation

{ TCustomMKOTask }

function TCustomMKOTask.ParseParams(const _Params: String): TArray<String>;
begin
  Result := _Params.Split([' ', CRLF, CR, LF]);
end;

procedure TCustomMKOTask.ValidateParams(const _Params: WideString);
begin
  ValidateParams(ParseParams(_Params));
end;

procedure TCustomMKOTask.Start(const _Params: WideString);
begin
  Start(ParseParams(_Params));
end;

procedure TCustomMKOTask.ValidateParams(const _Params: TArray<String>);
begin
end;

procedure TCustomMKOTask.Start(const _Params: TArray<String>);
begin
end;

end.
