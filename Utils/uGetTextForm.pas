unit uGetTextForm;

interface

uses
  { VCL }
  System.Classes, Vcl.Forms, Winapi.Windows, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls;

type

  TfmGetTextForm = class(TForm)

    pCommon: TGridPanel;
    pContent: TPanel;
    pButtons: TPanel;

    lText: TLabel;
    mParams: TMemo;

    bOk: TButton;
    bCancel: TButton;

    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  strict private

    function GetContext: String;

  private

    constructor Create(const _Caption, _Text: String); reintroduce;

    property Context: String read GetContext;

  end;

function InputText(const Caption, Text: String; var Value: String): Boolean;

implementation

{$R *.dfm}

function InputText(const Caption, Text: String; var Value: String): Boolean;
var
  Form: TfmGetTextForm;
begin

  Form := TfmGetTextForm.Create(Caption, Text);
  try

    Result := Form.ShowModal = mrOk;
    if Result then
      Value := Form.Context;

  finally
    Form.Free;
  end;

end;

{ TfmGetParamsForm }

constructor TfmGetTextForm.Create(const _Caption, _Text: String);
begin

  inherited Create(Application.MainForm);

  Caption := _Caption;
  lText.Caption := _Text;

end;

procedure TfmGetTextForm.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if Ord(Key) = VK_ESCAPE then
  begin

    ModalResult := mrCancel;
    CloseModal;

  end;

end;

procedure TfmGetTextForm.FormShow(Sender: TObject);
var
  Text: String;
begin

  { Глюк выравнивания на панели VCL stub. }
  Text := lText.Caption;
  lText.Caption := '';
  lText.Caption := Text;

end;

function TfmGetTextForm.GetContext: String;
begin
  Result := mParams.Lines.Text;
end;

end.
