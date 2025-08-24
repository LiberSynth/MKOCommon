unit uCustomTasks;

interface

uses
  { Common }
  uInterfaces;

type

  TCustomTask = class abstract (TInterfacedObject, IMKOTask)

  protected

    { IMKOTask }
    function GetName: WideString; virtual; safecall; abstract;
    function GetCaption: WideString; virtual; safecall; abstract;
    function GetDescription: WideString; virtual; safecall; abstract;
    function GetParamsHelpText: WideString; virtual; safecall; abstract;
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; virtual; safecall; abstract;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; virtual; safecall; abstract;

  end;

  TCustomMKOTaskInstance = class abstract (TInterfacedObject, IMKOTaskInstance)

  strict private

    FTerminated: Boolean;
    FParams: IMKOTaskParams;
    FOutputIntf: IMKOTaskOutput;

  protected

    { IMKOTaskInstance }
    procedure Execute(const _OutputIntf: IMKOTaskOutput); virtual; safecall;
    procedure Terminate; virtual; safecall;

    procedure Init(const _OutputIntf: IMKOTaskOutput); virtual;
    procedure WriteOut(const _Value: WideString; _Progress: ShortInt);

    property Terminated: Boolean read FTerminated;
    property Params: IMKOTaskParams read FParams;
    property OutputIntf: IMKOTaskOutput read FOutputIntf;

  public

    constructor Create(const _Params: IMKOTaskParams);

  end;

implementation

{ TCustomMKOTaskInstance }

constructor TCustomMKOTaskInstance.Create(const _Params: IMKOTaskParams);
begin
  inherited Create;
  FParams := _Params;
end;

procedure TCustomMKOTaskInstance.Execute(const _OutputIntf: IMKOTaskOutput);
begin
  Init(_OutputIntf);
end;

procedure TCustomMKOTaskInstance.Init(const _OutputIntf: IMKOTaskOutput);
begin
  FOutputIntf := _OutputIntf;
end;

procedure TCustomMKOTaskInstance.Terminate;
begin
  FTerminated := True;
end;

procedure TCustomMKOTaskInstance.WriteOut(const _Value: WideString; _Progress: ShortInt);
begin
  if not Terminated then
    OutputIntf.WriteOut(_Value, _Progress);
end;

end.
