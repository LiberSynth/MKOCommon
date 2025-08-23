unit uInterfaces;

interface

type

  IMKOTaskOutput = interface

    ['{9E53166A-727B-4B11-B091-BDB4182AF34C}']

    procedure WriteOut(const _Value: WideString; _Progress: Integer); safecall;

  end;

  IMKOTaskParams = interface

    ['{ADB67800-3C89-4A5A-AA71-9D94FCC602DD}']

    function GetItems(_Index: Integer): WideString; safecall;
    procedure SetItems(_Index: Integer; const _Value: WideString); safecall;
    function GetCount: Integer; safecall;
    function GetErrorMessage: WideString; safecall;
    procedure SetErrorMessage(const _Value: WideString); safecall;
    procedure Delete(_Index: Integer); safecall;
    function ToString: WideString; safecall;

    property Items[_Index: Integer]: WideString read GetItems write SetItems; default;
    property Count: Integer read GetCount;
    property ErrorMessage: WideString read GetErrorMessage write SetErrorMessage;

  end;

  IMKOTaskInstance = interface

    ['{BB1478EA-61D2-428B-ACF6-187DBA5430AA}']
    {TODO 5 -oVasilevSM : ƒобавить в описание: этот метод запускаетс€ отдельным потоком, поэтому в его исполнении нужно обеспечивать междупоточную синхронизацию дл€ общих ресурсов. }
    procedure Execute(const _OutputIntf: IMKOTaskOutput); safecall;
    procedure Terminate; safecall;

  end;

  IMKOTask = interface

    ['{FD8BA618-01E2-4972-9BE7-BC4EA9E16AA5}']

    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; safecall;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; safecall;

    property Name: WideString read GetName;
    property Caption: WideString read GetCaption;
    property Description: WideString read GetDescription;
    property ParamsHelpText: WideString read GetParamsHelpText;

  end;

  IMKOTaskLibrary = interface

    ['{7B8886F4-4483-42DD-B45C-BAA13E78B10A}']

    procedure RegisterTask(_MKOTask: IMKOTask); safecall;

  end;

implementation

end.
