unit Common.uGetTextForm;

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
    procedure SetContext(const _Value: String);

  private

    constructor Create(const _Caption, _Text: String); reintroduce;

    property Context: String read GetContext write SetContext;

  end;

{TODO 5 -oVasilevSM : Фреймворк может работать для консольных приложений и служб. }
function InputText(const Caption, Text: String; var Value: String): Boolean;

implementation

{$R *.dfm}

function InputText(const Caption, Text: String; var Value: String): Boolean;
var
  Form: TfmGetTextForm;
begin

  Form := TfmGetTextForm.Create(Caption, Text);
  try

    Form.Context := Value;
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

  { Глюк выравнивания на панели VCL. При установке текста в TLabel при создании
    или показе формы под ним образуется пустое пространство почему-то. Этот
    костыль решает проблему, хоть он и костыль. }
  Text := lText.Caption;
  lText.Caption := '';
  lText.Caption := Text;

end;

function TfmGetTextForm.GetContext: String;
begin
  Result := mParams.Lines.Text;
end;

procedure TfmGetTextForm.SetContext(const _Value: String);
begin
  mParams.Lines.Text := _Value;
  mParams.SelStart := Length(_Value);
end;

end.
