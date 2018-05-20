object BGColor: TBGColor
  Left = 0
  Top = 0
  Caption = 'BGColor'
  ClientHeight = 145
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RedLabel: TLabel
    Left = 24
    Top = 16
    Width = 19
    Height = 13
    Caption = 'Red'
  end
  object GreenLabel: TLabel
    Left = 24
    Top = 56
    Width = 29
    Height = 13
    Caption = 'Green'
  end
  object BlueLabel: TLabel
    Left = 24
    Top = 104
    Width = 20
    Height = 13
    Caption = 'Blue'
  end
  object PreviewLabel: TLabel
    Left = 152
    Top = 13
    Width = 38
    Height = 13
    Caption = 'Preview'
  end
  object Image1: TImage
    Left = 152
    Top = 32
    Width = 113
    Height = 107
  end
  object RedSpin: TSpinEdit
    Left = 64
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = RedSpinChange
  end
  object GreenSpin: TSpinEdit
    Left = 64
    Top = 53
    Width = 49
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = GreenSpinChange
  end
  object BlueSpin: TSpinEdit
    Left = 64
    Top = 101
    Width = 49
    Height = 22
    MaxValue = 15
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = BlueSpinChange
  end
end
