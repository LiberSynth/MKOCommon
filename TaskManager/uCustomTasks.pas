unit uCustomTasks;

interface

uses
  { VCL }
  System.SysUtils,
  { Common }
  uInterfaces, Common.uUtils;

type

  TCustomMKOTask = class(TInterfacedObject, IMKOTask)

  protected

    { IMKOTask }
    function GetName: WideString; virtual; safecall; abstract;
    function GetCaption: WideString; virtual; safecall; abstract;
    function GetDescription: WideString; virtual; safecall; abstract;
    function GetParamsHelpText: WideString; virtual; safecall; abstract;
    procedure ValidateParams(var _Params: WideString); overload; virtual; safecall;
    function StartTask(const _Params: WideString): IMKOTaskInstance; overload; virtual; safecall;

    procedure ValidateParams(const _Params: TArray<String>); overload; virtual;
    function StartTask(const _Params: TArray<String>): IMKOTaskInstance; overload; virtual; safecall; abstract;

  end;

implementation

{ TCustomMKOTask }

procedure TCustomMKOTask.ValidateParams(var _Params: WideString);
begin
  ValidateParams(ParseParams(_Params));
end;

function TCustomMKOTask.StartTask(const _Params: WideString): IMKOTaskInstance;
begin
  Result := StartTask(ParseParams(_Params));
end;

procedure TCustomMKOTask.ValidateParams(const _Params: TArray<String>);
begin
end;

end.
