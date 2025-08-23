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
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; overload; virtual; safecall;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; overload; virtual; safecall;

    function ValidateParams(const _Params: TArray<String>): Boolean; overload; virtual;
    function StartTask(const _Params: TArray<String>): IMKOTaskInstance; overload; virtual; safecall; abstract;

  end;

implementation

{ TCustomMKOTask }

function TCustomMKOTask.ValidateParams(const _Params: IMKOTaskParams): LongBool;
begin
//  Result := ValidateParams(ParseParams(_Params.));
end;

function TCustomMKOTask.StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance;
begin
//  Result := StartTask(ParseParams(_Params));
end;

function TCustomMKOTask.ValidateParams(const _Params: TArray<String>): Boolean;
begin
end;

end.
