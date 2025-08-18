unit uInterfaces;

interface

type

  IMKOTask = interface

    ['{FD8BA618-01E2-4972-9BE7-BC4EA9E16AA5}']

    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    procedure ValidateParams(const _Params: WideString); safecall;
    procedure Start(const _Params: WideString); safecall;
    procedure Cancel; safecall;

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
