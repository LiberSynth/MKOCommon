unit uInterfaces;

interface

type

  IMKOTaskLibrary = interface

    ['{7B8886F4-4483-42DD-B45C-BAA13E78B10A}']

    procedure RegisterTask(

        const _Name: WideString;
        const _Caption: WideString;
        const _Description: WideString

    ); safecall;

  end;

implementation

end.
