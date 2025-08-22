unit uInterfaces;

interface

type

  IMKOTaskWiteOut = interface

    ['{9E53166A-727B-4B11-B091-BDB4182AF34C}']

    procedure WriteOut(const _Value: WideString); safecall;

  end;

  IMKOTaskInstance = interface

    ['{BB1478EA-61D2-428B-ACF6-187DBA5430AA}']
    {TODO 4 -oVasilevSM : ƒобавить в описание: этот метод запускаетс€ отдельным потоком, поэтому в его исполнении нужно обеспечивать междупоточную синхронизацию дл€ общих ресурсов. }
    procedure Execute(_WriteOutIntf: IMKOTaskWiteOut); safecall;
    procedure Terminate; safecall;

  end;

  IMKOTask = interface

    ['{FD8BA618-01E2-4972-9BE7-BC4EA9E16AA5}']

    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    procedure ValidateParams(var _Params: WideString); safecall;
    function StartTask(const _Params: WideString): IMKOTaskInstance; safecall;

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
