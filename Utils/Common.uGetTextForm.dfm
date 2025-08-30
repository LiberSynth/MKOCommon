object fmGetTextForm: TfmGetTextForm
  Left = 0
  Top = 0
  Caption = 'Create: _Caption'
  ClientHeight = 281
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object pCommon: TGridPanel
    Left = 0
    Top = 0
    Width = 464
    Height = 281
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pContent
        Row = 0
      end
      item
        Column = 0
        Control = pButtons
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 34.000000000000000000
      end>
    TabOrder = 0
    object pContent: TPanel
      Left = 0
      Top = 0
      Width = 464
      Height = 247
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object lText: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 10
        Width = 456
        Height = 15
        Margins.Left = 4
        Margins.Top = 10
        Margins.Right = 4
        Margins.Bottom = 10
        Align = alTop
        Alignment = taCenter
        Caption = 'Create: _Text'
        WordWrap = True
        ExplicitWidth = 66
      end
      object mParams: TMemo
        AlignWithMargins = True
        Left = 4
        Top = 35
        Width = 456
        Height = 212
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object pButtons: TPanel
      Left = 0
      Top = 247
      Width = 464
      Height = 34
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        464
        34)
      object bOk: TButton
        Left = 303
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1054#1050
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object bCancel: TButton
        Left = 385
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
end
