object Editor: TEditor
  Left = 0
  Top = 0
  Caption = 'Editor'
  ClientHeight = 384
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TilesImage: TImage
    Left = 8
    Top = 31
    Width = 640
    Height = 608
    OnMouseDown = TilesImageMouseDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 563
    Height = 25
    Caption = 'ToolBar1'
    TabOrder = 0
    object DrawButton: TSpeedButton
      Left = 0
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 2
      Glyph.Data = {
        46060000424D4606000000000000360400002800000017000000160000000100
        0800000000001002000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF0000000000FFFFFF00FFFFFFFFFFFFFFFFFFFFFF000000
        000808000000FFFFFF00FFFFFFFFFFFFFFFFFF0000080808080808080000FFFF
        FF00FFFFFFFFFFFFFFFFFF0000000808080808080800FFFFFF00FFFFFFFFFFFF
        FFFF00FBFB000008080808080000FFFFFF00FFFFFFFFFFFFFF00FBFBFBFB0000
        0808080800FFFFFFFF00FFFFFFFFFFFF00FBFBFBFBFBFBFB0000080800FFFFFF
        FF00FFFFFFFFFF00FBFBFBFBFBFBFBFBFB00000800FFFFFFFF00FFFFFFFF00FB
        FBFBFBFBFBFBFBFBFBFB000000FFFFFFFF00FFFFFF00FBFBFBFBFBFBFBFBFBFB
        FBFBFB00FFFFFFFFFF00FFFF00FBFBFBFBFBFBFBFBFBFBFBFBFB00FFFFFFFFFF
        FF00FF00FBFBFBFBFBFBFBFBFBFBFBFBFB00FFFFFFFFFFFFFF000000FBFBFBFB
        FBFBFBFBFBFBFBFB00FFFFFFFFFFFFFFFF00FF0000FBFBFBFBFBFBFBFBFBFB00
        FFFFFFFFFFFFFFFFFF00FFFF0000FBFBFBFBFBFBFBFB00FFFFFFFFFFFFFFFFFF
        FF00FFFFFF0000FBFBFBFBFBFB00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFF0000
        00FBFB0000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF00000000FFFFFFFF
        FFFFFFFFFFFFFFFFFF00}
      OnClick = DrawButtonClick
    end
    object SelectButton: TSpeedButton
      Left = 23
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 2
      Glyph.Data = {
        46060000424D4606000000000000360400002800000017000000160000000100
        0800000000001002000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF00FFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFF0000FFFFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF0000
        FFFFFFFFFF00FFFFFF00FFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFF0000FFFF
        FF00FFFFFF0000000000FFFF0000FFFFFFFFFF0000FFFFFFFF00FFFFFFFF00FF
        FFFF000000FFFFFFFFFF0000FFFFFFFFFF00FFFFFFFF00FFFFFF0000FFFFFFFF
        FF0000FFFFFFFFFFFF00FFFFFFFF00FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FF00FFFFFFFF00FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF00FFFFFF00FFFF
        FFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFF00
        FFFFFFFFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
        FF00FFFFFF00FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF00FFFFFF000000
        000000000000000000000000FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00}
      OnClick = SelectButtonClick
    end
    object Color0: TSpeedButton
      Left = 46
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 1
      Caption = '0'
      OnClick = Color0Click
    end
    object Color1: TSpeedButton
      Left = 69
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 1
      Caption = '1'
      OnClick = Color1Click
    end
    object Color2: TSpeedButton
      Left = 92
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 1
      Caption = '2'
      OnClick = Color2Click
    end
    object Color3: TSpeedButton
      Left = 115
      Top = 0
      Width = 23
      Height = 22
      GroupIndex = 1
      Caption = '3'
      OnClick = Color3Click
    end
    object ScalingLabel: TLabel
      Left = 138
      Top = 0
      Width = 53
      Height = 22
      Alignment = taCenter
      AutoSize = False
      Caption = ' Scaling Factor'
      Color = clBtnFace
      ParentColor = False
      WordWrap = True
    end
    object ScalingSpin: TSpinEdit
      Left = 191
      Top = 0
      Width = 48
      Height = 22
      MaxValue = 40
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = ScalingSpinChange
    end
    object XLabel: TLabel
      Left = 239
      Top = 0
      Width = 64
      Height = 22
      AutoSize = False
      Caption = '  Num Tiles X'
    end
    object XSpin: TSpinEdit
      Left = 303
      Top = 0
      Width = 48
      Height = 22
      MaxValue = 20
      MinValue = 1
      TabOrder = 1
      Value = 1
      OnChange = XSpinChange
    end
    object YLabel: TLabel
      Left = 351
      Top = 0
      Width = 64
      Height = 22
      AutoSize = False
      Caption = '  Num Tiles Y'
    end
    object YSpin: TSpinEdit
      Left = 415
      Top = 0
      Width = 48
      Height = 22
      MaxValue = 19
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = YSpinChange
    end
    object PaletteLabel: TLabel
      Left = 463
      Top = 0
      Width = 40
      Height = 22
      Caption = '  Palette'
    end
    object PaletteSpin: TSpinEdit
      Left = 503
      Top = 0
      Width = 50
      Height = 22
      MaxValue = 15
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = PaletteSpinChange
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 365
    Width = 563
    Height = 19
    Panels = <
      item
        Text = 'Selected Tile X: 0 Y: 0'
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 480
    Top = 32
    object FileMenu: TMenuItem
      Caption = 'File'
      object Import: TMenuItem
        Caption = 'Import Grayscale BMP'
        OnClick = ImportClick
      end
      object Export: TMenuItem
        Caption = 'Export Image'
        OnClick = ExportClick
      end
      object ExportPalette1: TMenuItem
        Caption = 'Export Palette'
        OnClick = ExportPalette1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Palette1: TMenuItem
      Caption = 'Palette'
      object Edit: TMenuItem
        Caption = 'Edit'
        OnClick = EditClick
      end
      object EditBG: TMenuItem
        Caption = 'Edit BG Color'
        OnClick = EditBGClick
      end
    end
  end
end
