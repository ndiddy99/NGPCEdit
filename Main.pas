unit Main;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Menus,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Samples.Spin, Math, Color, BGColorForm, Common;
type
  TEditor = class(TForm)
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    ToolBar1: TToolBar;
    Color0: TSpeedButton;
    Color1: TSpeedButton;
    Color2: TSpeedButton;
    Color3: TSpeedButton;
    ScalingSpin: TSpinEdit;
    ScalingLabel: TLabel;
    XLabel: TLabel;
    XSpin: TSpinEdit;
    YLabel: TLabel;
    YSpin: TSpinEdit;
    Export: TMenuItem;
    DrawButton: TSpeedButton;
    SelectButton: TSpeedButton;
    StatusBar1: TStatusBar;
    PaletteLabel: TLabel;
    PaletteSpin: TSpinEdit;
    Palette1: TMenuItem;
    Edit: TMenuItem;
    Import: TMenuItem;
    ExportPalette1: TMenuItem;
    TilesImage: TImage;
    EditBG: TMenuItem;
    DarkenButton: TSpeedButton;
    LightenButton: TSpeedButton;
    PaletteButton: TSpeedButton;
    SaveImage: TMenuItem;
    LoadImage: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Color0Click(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure Color2Click(Sender: TObject);
    procedure Color3Click(Sender: TObject);
    procedure ScalingSpinChange(Sender: TObject);
    procedure XSpinChange(Sender: TObject);
    procedure YSpinChange(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure DrawButtonClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure ExportPalette1Click(Sender: TObject);
    procedure ImportClick(Sender: TObject);
    procedure SetPixelValue(x, y: Integer; value: Byte);
    function GetPixelValue(x, y: Integer): Byte;
    procedure EditBGClick(Sender: TObject);
    procedure TilesImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TilesImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HandleImage(X, Y: Integer);
    procedure DarkenButtonClick(Sender: TObject);
    procedure LightenButtonClick(Sender: TObject);
    procedure TilesImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaletteButtonClick(Sender: TObject);
    procedure SaveImageClick(Sender: TObject);
    procedure LoadImageClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  DEFAULT_COLORS : array [0..3] of TColor = (clWhite, clLtGray, clDkGray, clBlack);
  PIXELS_PER_TILE = 8;
  COLORS_PER_TILE = 4;
  NUM_PALETTES = 16;
  GRID_PADDING = 10; //num of pixels to pad out grid by
  WINDOW_X_PADDING = 40;
  WINDOW_Y_PADDING = 120;
  MIN_WINDOW_WIDTH = 760;
  MIN_WINDOW_HEIGHT = 379;
  MAX_GRID_WIDTH = 1500;
  MAX_GRID_HEIGHT = 1000;
  TAB = #9;
  NEWLINE = #13#10;
  STATE_DRAW = 0;
  STATE_SELECT = 1;
  STATE_DARKEN = 2;
  STATE_LIGHTEN = 3;
  STATE_PALETTE = 4;

var
  Editor: TEditor;
  CommonInst: TCommon;
  CurrColor: Integer; //current color (1=black, 4=white)
  ScalingFactor: Integer;
  ToolState: Integer;
  NumTilesX, NumTilesY: Integer;
  SelectedX, SelectedY: Integer; //selected TILE not pixel
  LastLDX, LastLDY: Integer; //coords of last lightened/darkened tile
  IsMouseDown: Boolean;


implementation

{$R *.dfm}

procedure TEditor.FormCreate(Sender: TObject); //init procedure
var i, j: Integer;
begin
  CommonInst := Common.TCommon.Create;
  CurrColor := 0;
  NumTilesX := 1;
  NumTilesY := 1;
  SelectedX := 0;
  SelectedY := 0;
  LastLDX := -1;
  LastLDY := -1;
  IsMouseDown := False;
  ToolState := STATE_SELECT;
  SelectButton.Down := True;
  Color0.Down := True;
  SetLength(TileMap, NumTilesX, NumTilesY);
  SetLength(PaletteIndexes, NumTilesX, NumTilesY);
  TilesImage.Canvas.FillRect(Rect(0,0,TilesImage.Width,TilesImage.Height));
  for i := 0 to 15 do
    for j := 0 to 3 do
      Palettes[i][j] := DEFAULT_COLORS[j];
  ScalingFactor := 2;
  ScalingSpin.Value := 2;

end;



procedure TEditor.TilesImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HandleImage(X, Y);
  IsMouseDown := True;
end;

procedure TEditor.TilesImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if IsMouseDown then
    HandleImage(X, Y);
end;

procedure TEditor.HandleImage(X: Integer; Y: Integer);
var FittedX, FittedY, PixelX, PixelY, i, j: Integer;
begin
  if (X >= 0) and (Y >= 0) and (X < TilesImage.Width) and (Y < TilesImage.Height) then
  begin
    SelectedX := X div (PIXELS_PER_TILE * ScalingFactor);
    SelectedY := Y div (PIXELS_PER_TILE * ScalingFactor);
    if ToolState = STATE_DRAW then
    begin
      PixelX := (X div ScalingFactor) mod PIXELS_PER_TILE;
      PixelY := (Y div ScalingFactor) mod PIXELS_PER_TILE;
      FittedX := (X div ScalingFactor) * ScalingFactor; //make sure x/y vals are "locked to scaled pixel boundaries"
      FittedY := (Y div ScalingFactor) * ScalingFactor;
      TileMap[SelectedX,SelectedY][PixelX,PixelY] := CurrColor;
      TilesImage.Canvas.Brush.Color := Palettes[PaletteIndexes[SelectedX,SelectedY]][TileMap[SelectedX,SelectedY][PixelX,PixelY]];
      TilesImage.Canvas.FillRect(Rect(FittedX , FittedY, FittedX + ScalingFactor, FittedY + ScalingFactor));
    end
    else if (ToolState = STATE_DARKEN) and ((LastLDX <> SelectedX) or (LastLDY <> SelectedY)) then
    begin
      for j := 0 to PIXELS_PER_TILE do
        for i := 0 to PIXELS_PER_TILE do
        begin
          if TileMap[SelectedX][SelectedY][i][j] <> 3 then //don't let user darken tile past 2bpp
            Inc(TileMap[SelectedX][SelectedY][i][j]);
        end;
      CommonInst.DrawTile(SelectedX, SelectedY);
      LastLDX := SelectedX;
      LastLDY := SelectedY;
    end
    else if (ToolState = STATE_LIGHTEN) and ((LastLDX <> SelectedX) or (LastLDY <> SelectedY)) then
    begin
      for j := 0 to PIXELS_PER_TILE do
        for i := 0 to PIXELS_PER_TILE do
        begin
          if TileMap[SelectedX][SelectedY][i][j] <> 0 then //don't let user lighten tile past 2bpp
            Dec(TileMap[SelectedX][SelectedY][i][j]);
        end;
      CommonInst.DrawTile(SelectedX, SelectedY);
      LastLDX := SelectedX;
      LastLDY := SelectedY;
    end
    else if ToolState = STATE_PALETTE then
    begin
      PaletteIndexes[SelectedX][SelectedY] := PaletteSpin.Value;
      CommonInst.DrawTile(SelectedX, SelectedY);
    end;
    StatusBar1.Panels[0].Text := 'Selected Tile X: ' + IntToStr(SelectedX) + ' Y: ' + IntToStr(SelectedY);
    if ToolState <> STATE_PALETTE then
      PaletteSpin.Value := PaletteIndexes[SelectedX, SelectedY];
  end;
end;

procedure TEditor.TilesImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown := False;
  LastLDX := -1;
  LastLDY := -1;
end;

procedure TEditor.ImportClick(Sender: TObject);
var
 OpenDialog: TOpenDialog;
 Image: TBitmap;
 Line: pByteArray;
 i, j: Integer;
begin
  OpenDialog := TOpenDialog.Create(self);
  OpenDialog.Options := [ofFileMustExist];
  OpenDialog.Title := 'Find an image to import from';
  OpenDialog.Filter := '8-bit greyscale bitmap|*.bmp';
  OpenDialog.FilterIndex := 1;
  if OpenDialog.Execute then
  begin
    Image := TBitmap.Create;
    Image.LoadFromFile(OpenDialog.FileName);
    XSpin.Value := Image.Width div PIXELS_PER_TILE;
    YSpin.Value := Image.Height div PIXELS_PER_TILE;
    for i := 0 to Image.Height - 1 do
    begin
      Line := pByteArray(Image.ScanLine[i]);
      for j := 0 to Image.Width - 1 do
      begin
        if Line[j] < 64 then
          SetPixelValue(j, i, 3)
        else if Line[j] < 128 then
          SetPixelValue(j, i, 2)
        else if Line[j] < 192 then
          SetPixelValue(j, i, 1)
        else
          SetPixelValue(j, i, 0);
      end;
    end;
  end;
  CommonInst.Redraw;
end;

procedure TEditor.LightenButtonClick(Sender: TObject);
begin
  ToolState := STATE_LIGHTEN;
end;

procedure TEditor.LoadImageClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  LoadFile: TextFile;
  i, j, temp: Integer;
begin
  OpenDialog := TOpenDialog.Create(self);
  OpenDialog.Title := 'Enter a filename to load from';
  OpenDialog.Filter := 'NGPCEdit file|*.zongo';
  OpenDialog.DefaultExt := 'zongo';
  OpenDialog.FilterIndex := 1;
  if OpenDialog.Execute then
  begin
    AssignFile(LoadFile, OpenDialog.FileName);
    OpenDialog.Free;
    Reset(LoadFile);
    ReadLn(LoadFile, temp); //want to do the value instead of changing
    XSpin.Value := temp;
    ReadLn(LoadFile, temp); //variable names directly so the onchange event runs
    YSpin.Value := temp;
    for i := 0 to NUM_PALETTES - 1 do
      for j := 0 to COLORS_PER_TILE - 1 do
        ReadLn(LoadFile, Palettes[i][j]);
    for j := 0 to (NumTilesY * PIXELS_PER_TILE) - 1 do
      for i := 0 to (NumTilesX * PIXELS_PER_TILE) - 1 do
      begin
        ReadLn(LoadFile, temp);
        SetPixelValue(i, j, temp);
      end;
    for j := 0 to NumTilesY - 1 do
      for i := 0 to NumTilesX - 1 do
        ReadLn(LoadFile, PaletteIndexes[i][j]);
    CommonInst.Redraw;
    CloseFile(LoadFile);
  end
  else
    OpenDialog.Free;
end;

//makes TileMap addressable like a 2d array of pixels
procedure TEditor.SetPixelValue(x, y: Integer; value: Byte);
begin
  TileMap[x div PIXELS_PER_TILE][y div PIXELS_PER_TILE][x mod PIXELS_PER_TILE][y mod PIXELS_PER_TILE] := value;
end;

function TEditor.GetPixelValue(x: Integer; y: Integer): Byte;
begin
  Result := TileMap[x div PIXELS_PER_TILE][y div PIXELS_PER_TILE][x mod PIXELS_PER_TILE][y mod PIXELS_PER_TILE];
end;

procedure TEditor.PaletteButtonClick(Sender: TObject);
begin
  ToolState := STATE_PALETTE;
end;

procedure TEditor.SaveImageClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  SaveFile: TextFile;
  i, j: Integer;
begin
  SaveDialog := TSaveDialog.Create(self);
  SaveDialog.Title := 'Enter a filename to save to';
  SaveDialog.Filter := 'NGPCEdit file|*.zongo';
  SaveDialog.DefaultExt := 'zongo';
  SaveDialog.FilterIndex := 1;
  if SaveDialog.Execute then
  begin
    AssignFile(SaveFile, SaveDialog.FileName);
    SaveDialog.Free;
    ReWrite(SaveFile);
    Writeln(SaveFile, IntToStr(NumTilesX));
    Writeln(SaveFile, IntToStr(NumTilesY));
    for i := 0 to NUM_PALETTES - 1 do
      for j := 0 to COLORS_PER_TILE - 1 do
        WriteLn(SaveFile, IntToStr(Palettes[i][j]));
    for j := 0 to (NumTilesY * PIXELS_PER_TILE) - 1 do
      for i := 0 to (NumTilesX * PIXELS_PER_TILE) - 1 do
        WriteLn(SaveFile, IntToStr(GetPixelValue(i, j)));
    for j := 0 to NumTilesY - 1 do
      for i := 0 to NumTilesX - 1 do
        WriteLn(SaveFile, IntToStr(PaletteIndexes[i][j]));
    CloseFile(SaveFile);
  end
  else
    SaveDialog.Free;
end;

procedure TEditor.ScalingSpinChange(Sender: TObject);
begin
  ScalingFactor := ScalingSpin.Value;
  TilesImage.Width := NumTilesX * PIXELS_PER_TILE * ScalingFactor;
  TilesImage.Height := NumTilesY * PIXELS_PER_TILE * ScalingFactor;
  CommonInst.Redraw;
end;

procedure TEditor.XSpinChange(Sender: TObject);
var
  i, j: Integer;
  BlankTile: TTile;
begin
  SetLength(TileMap, XSpin.Value, NumTilesY);
  if NumTilesX < XSpin.Value then
  begin
    for i := 0 to PIXELS_PER_TILE - 1 do
      for j := 0 to PIXELS_PER_TILE - 1 do
        BlankTile[i][j] := 0;

    for j := 0 to NumTilesY - 1 do
      for i := NumTilesX to XSpin.Value - 1 do
        TileMap[i][j] := BlankTile;
  end;
  NumTilesX := XSpin.Value;
  SetLength(PaletteIndexes, NumTilesX, NumTilesY);
  if NumTilesX*PIXELS_PER_TILE*ScalingFactor < MAX_GRID_WIDTH then
    TilesImage.Width := NumTilesX*PIXELS_PER_TILE*ScalingFactor
  else
    TilesImage.Width := MAX_GRID_WIDTH;
  if Self.WindowState <> wsMaximized then
    Editor.Width := Max(TilesImage.Width + WINDOW_X_PADDING, MIN_WINDOW_WIDTH);
  CommonInst.Redraw;
end;

procedure TEditor.YSpinChange(Sender: TObject);
var
  i, j: Integer;
  BlankTile: TTile;
begin
  SetLength(TileMap, NumTilesX, YSpin.Value);
  if NumTilesY < YSpin.Value then
  begin
    for i := 0 to PIXELS_PER_TILE - 1 do
      for j := 0 to PIXELS_PER_TILE - 1 do
        BlankTile[i][j] := 0;

    for j := NumTilesY to YSpin.Value - 1 do
      for i := 0 to NumTilesX - 1 do
        TileMap[i][j] := BlankTile;
  end;
  NumTilesY := YSpin.Value;
  SetLength(PaletteIndexes, NumTilesX, NumTilesY);
  if NumTilesY*PIXELS_PER_TILE*ScalingFactor < MAX_GRID_HEIGHT then
    TilesImage.Height := NumTilesY*PIXELS_PER_TILE*ScalingFactor
  else
    TilesImage.Height := MAX_GRID_HEIGHT;
  if Self.WindowState <> wsMaximized then
    Editor.Height := Max(TilesImage.Height + WINDOW_Y_PADDING, MIN_WINDOW_HEIGHT);
  CommonInst.Redraw;
end;

procedure TEditor.EditBGClick(Sender: TObject);
begin
  BGColor.Show;
end;

procedure TEditor.Color0Click(Sender: TObject);
begin
  CurrColor := 0;
  ToolState := STATE_DRAW;
  DrawButton.Down := True;
end;

procedure TEditor.Color1Click(Sender: TObject);
begin
  CurrColor := 1;
  ToolState := STATE_DRAW;
  DrawButton.Down := True;
end;

procedure TEditor.Color2Click(Sender: TObject);
begin
  CurrColor := 2;
  ToolState := STATE_DRAW;
  DrawButton.Down := True;
end;

procedure TEditor.Color3Click(Sender: TObject);
begin
  CurrColor := 3;
  ToolState := STATE_DRAW;
  DrawButton.Down := True;
end;

procedure TEditor.DarkenButtonClick(Sender: TObject);
begin
  ToolState := STATE_DARKEN;
end;

procedure TEditor.DrawButtonClick(Sender: TObject);
begin
  ToolState := STATE_DRAW;
end;

procedure TEditor.SelectButtonClick(Sender: TObject);
begin
  ToolState := STATE_SELECT;
end;

procedure TEditor.EditClick(Sender: TObject);
begin
  ColorPicker.Show;
end;

procedure TEditor.ExportClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  ExportFile: TextFile;
  i, j, k: Integer;
  HexString: String;
begin
  SaveDialog := TSaveDialog.Create(self);
  SaveDialog.Title := 'Enter a filename to export to';
  SaveDialog.Filter := 'C source|*.c';
  SaveDialog.DefaultExt := 'c';
  SaveDialog.FilterIndex := 1;
  if SaveDialog.Execute then
  begin
    AssignFile(ExportFile, SaveDialog.FileName);
    SaveDialog.Free;
    ReWrite(ExportFile);
    WriteLn(ExportFile,'const unsigned short Tiles[' +
      IntToStr(NumTilesX * NumTilesY) + '][' + IntToStr(PIXELS_PER_TILE) + '] = {');
    for j := 0 to NumTilesY - 1 do
      for i := 0 to NumTilesX - 1 do
      begin
        Write(ExportFile, TAB + TAB + '{');
        for k := 0 to PIXELS_PER_TILE - 1 do
        begin
          if k <> 0 then
             Write(ExportFile, ', ');
          HexString := IntToHex(TileMap[i][j][7][k] or (TileMap[i][j][6][k] shl 2) or
            (TileMap[i][j][5][k] shl 4) or (TileMap[i][j][4][k] shl 6) or (TileMap[i][j][3][k] shl 8) or
            (TileMap[i][j][2][k] shl 10) or (TileMap[i][j][1][k] shl 12) or (TileMap[i][j][0][k] shl 14));
          HexString := copy(HexString,5,4);
          Write(ExportFile,'0x' + HexString);
        end;
        if (i < NumTilesY-1) or (j < NumTilesX-1) then
          WriteLn(ExportFile, '},')
        else
          WriteLn(ExportFile, '}');
      end;
    Writeln(ExportFile, '};');
    CloseFile(ExportFile);
  end
  else
    SaveDialog.Free;

end;

procedure TEditor.ExportPalette1Click(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  ExportFile: TextFile;
  i, j: Integer;
  Color: TColor;
begin
  SaveDialog := TSaveDialog.Create(self);
  SaveDialog.Title := 'Enter a filename to export to';
  SaveDialog.Filter := 'C source|*.c';
  SaveDialog.DefaultExt := 'c';
  SaveDialog.FilterIndex := 1;
  if SaveDialog.Execute then
  begin
    AssignFile(ExportFile, SaveDialog.FileName);
    SaveDialog.Free;
    ReWrite(ExportFile);
    WriteLn(ExportFile, 'const u16 BGColor = RGB(' +
     IntToStr(GetRValue(ColorToRGB(Palettes[0][0])) div 16) + ', ' +
     IntToStr(GetGValue(ColorToRGB(Palettes[0][0])) div 16) + ', ' +
     IntToStr(GetBValue(ColorToRGB(Palettes[0][0])) div 16) + ');');
    WriteLn(ExportFile,'const u16 Palettes[16][3] = {');
    for i := 0 to 15 do
    begin
        if i <> 0 then
          Write(ExportFile, ', ' + NEWLINE);
        Write(ExportFile, TAB + '{');
        Color := Palettes[i][1]; //don't write color 0 because it's transparent
        Write(ExportFile, 'RGB(' + IntToStr(GetRValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetGValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetBValue(ColorToRGB(Color)) div 16) + '), ');
        Color := Palettes[i][2];
        Write(ExportFile, 'RGB(' + IntToStr(GetRValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetGValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetBValue(ColorToRGB(Color)) div 16) + '), ');
        Color := Palettes[i][3];
        Write(ExportFile, 'RGB(' + IntToStr(GetRValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetGValue(ColorToRGB(Color)) div 16) + ', ' +
          IntToStr(GetBValue(ColorToRGB(Color)) div 16) + ')}');
    end;
    WriteLn(ExportFile, NEWLINE + '};');
    WriteLn(ExportFile, 'const u8 paletteIndexes[' + IntToStr(NumTilesY) + '][' + IntToStr(NumTilesX) + '] = {');
    for j := 0 to NumTilesY - 1 do
    begin
      Write(ExportFile, TAB + '{');
      for i := 0 to NumTilesX - 1 do
      begin
        if i <> 0 then
          Write(ExportFile, ', ');
        Write(ExportFile, IntToStr(PaletteIndexes[i][j]));
      end;
      if j <> NumTilesY - 1 then
        Write(ExportFile, '},' + NEWLINE)
      else
        Write(ExportFile, '}' + NEWLINE + '};');
    end;

    CloseFile(ExportFile);
  end
  else
    SaveDialog.Free
end;

end.
