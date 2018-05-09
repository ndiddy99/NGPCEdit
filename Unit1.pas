unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Menus,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Samples.Spin, Math;

type
  TEditor = class(TForm)
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    Exit1: TMenuItem;
    ToolBar1: TToolBar;
    Color1: TSpeedButton;
    Color2: TSpeedButton;
    Color3: TSpeedButton;
    Color4: TSpeedButton;
    DrawGrid1: TDrawGrid;
    ScalingSpin: TSpinEdit;
    ScalingLabel: TLabel;
    XLabel: TLabel;
    XSpin: TSpinEdit;
    YLabel: TLabel;
    YSpin: TSpinEdit;
    Export: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure Color2Click(Sender: TObject);
    procedure Color3Click(Sender: TObject);
    procedure Color4Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ScalingSpinChange(Sender: TObject);
    procedure XSpinChange(Sender: TObject);
    procedure YSpinChange(Sender: TObject);
    procedure ExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TTile = array[0..8, 0..8] of Byte;
const
  POSSIBLE_COLORS : array [0..3] of TColor = (clWhite, clLtGray, clDkGray, clBlack);
  PIXELS_PER_TILE = 8;
  GRID_PADDING = 12; //num of pixels to pad out grid by
  WINDOW_X_PADDING = 40;
  WINDOW_Y_PADDING = 120;
  MIN_WINDOW_WIDTH = 600;
  MIN_WINDOW_HEIGHT = 379;
  MAX_GRID_WIDTH = 1500;
  MAX_GRID_HEIGHT = 900;
  TAB = #9;
var
  Editor: TEditor;
  CurrColor: Integer; //current color (1=black, 4=white)
  ScalingFactor: Integer;
  NumTilesX, NumTilesY: Integer;
  TileMap: array of array of TTile;
  IsDrawing: Boolean;

implementation

{$R *.dfm}

procedure TEditor.FormCreate(Sender: TObject); //init procedure
begin
  CurrColor := 0;
  ScalingFactor := 40;
  ScalingSpin.Value := 40;
  NumTilesX := 1;
  NumTilesY := 1;
  IsDrawing := False;
  SetLength(TileMap, NumTilesX, NumTilesY);
end;



procedure TEditor.ScalingSpinChange(Sender: TObject);
begin
  ScalingFactor := ScalingSpin.Value;
  DrawGrid1.DefaultColWidth := ScalingFactor;
  DrawGrid1.DefaultRowHeight := ScalingFactor;
  DrawGrid1.Invalidate;
end;

procedure TEditor.XSpinChange(Sender: TObject);
begin
  NumTilesX := XSpin.Value;
  SetLength(TileMap, NumTilesX, NumTilesY);
  DrawGrid1.ColCount := NumTilesX * PIXELS_PER_TILE;;
  if NumTilesX*PIXELS_PER_TILE*ScalingFactor + XSpin.Value * GRID_PADDING < MAX_GRID_WIDTH then
    DrawGrid1.Width := NumTilesX*PIXELS_PER_TILE*ScalingFactor + XSpin.Value * GRID_PADDING
  else
    DrawGrid1.Width := MAX_GRID_WIDTH;
  DrawGrid1.Invalidate;
  Editor.Width := Max(DrawGrid1.Width + WINDOW_X_PADDING, MIN_WINDOW_WIDTH);
end;

procedure TEditor.YSpinChange(Sender: TObject);
begin
  NumTilesY := YSpin.Value;
  SetLength(TileMap, NumTilesX, NumTilesY);
  DrawGrid1.RowCount := NumTilesY * PIXELS_PER_TILE;
  if NumTilesY*PIXELS_PER_TILE*ScalingFactor * GRID_PADDING < MAX_GRID_HEIGHT then
    DrawGrid1.Height := NumTilesY*PIXELS_PER_TILE*ScalingFactor * GRID_PADDING
  else
    DrawGrid1.Height := MAX_GRID_HEIGHT;
  DrawGrid1.Invalidate;
  Editor.Height := Max(DrawGrid1.Height + WINDOW_Y_PADDING, MIN_WINDOW_HEIGHT);
end;

procedure TEditor.Color1Click(Sender: TObject);
begin
  CurrColor := 0;
end;

procedure TEditor.Color2Click(Sender: TObject);
begin
  CurrColor := 1;
end;

procedure TEditor.Color3Click(Sender: TObject);
begin
  CurrColor := 2;
end;

procedure TEditor.Color4Click(Sender: TObject);
begin
  CurrColor := 3;
end;

procedure TEditor.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var TileX, TileY, PixelX, PixelY: Integer;
begin
  TileX := ACol div PIXELS_PER_TILE;
  TileY := ARow div PIXELS_PER_TILE;
  PixelX := ACol mod PIXELS_PER_TILE;
  PixelY := ARow mod PIXELS_PER_TILE;
  DrawGrid1.Canvas.Brush.Color := POSSIBLE_COLORS[TileMap[TileX,TileY][PixelX,PixelY]];
  DrawGrid1.Canvas.FillRect(Rect);
end;

//procedure TEditor.DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
//  Shift: TShiftState; X, Y: Integer);
//begin
//  TileMap[((X - DrawGrid1.Left) div ScalingFactor), (Y div ScalingFactor)] := CurrColor;
//  IsDrawing := True;
//  DrawGrid1.Invalidate;
//end;
//
//procedure TEditor.DrawGrid1MouseLeave(Sender: TObject);
//begin
//  IsDrawing := False;
//end;
//
//procedure TEditor.DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
//  Y: Integer);
//var
//  XArrIndex, YArrIndex: Integer;
//begin
//  XArrIndex := (X - DrawGrid1.Left) div ScalingFactor;
//  YArrIndex := Y div ScalingFactor;
//  if IsDrawing and (XArrIndex < NumTilesX) and (YArrIndex < NumTilesY) then
//    begin
//        TileMap[((X - DrawGrid1.Left) div ScalingFactor), (Y div ScalingFactor)] := CurrColor;
//        DrawGrid1.Invalidate;
//    end;
//end;
//
//procedure TEditor.DrawGrid1MouseUp(Sender: TObject; Button: TMouseButton;
//  Shift: TShiftState; X, Y: Integer);
//begin
//  IsDrawing := False;
//  DrawGrid1.Invalidate;
//end;

procedure TEditor.DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var TileX, TileY, PixelX, PixelY: Integer;
begin
  TileX := ACol div PIXELS_PER_TILE;
  TileY := ARow div PIXELS_PER_TILE;
  PixelX := ACol mod PIXELS_PER_TILE;
  PixelY := ARow mod PIXELS_PER_TILE;
  TileMap[TileX,TileY][PixelX,PixelY] := CurrColor;
  DrawGrid1.Invalidate;
end;

procedure TEditor.Exit1Click(Sender: TObject);
begin
  Editor.Close;
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
  SaveDialog.Execute;
  AssignFile(ExportFile, SaveDialog.FileName);
  SaveDialog.Free;
  ReWrite(ExportFile);
  WriteLn(ExportFile,'const unsigned short Tiles[' +
    IntToStr(NumTilesX * NumTilesY) + '][' + IntToStr(PIXELS_PER_TILE) + '] = {');
  for i := 0 to NumTilesX - 1 do
    for j := 0 to NumTilesY - 1 do
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
      if j < NumTilesY - 1 then
        WriteLn(ExportFile, '},')
      else
        WriteLn(ExportFile, '}');
    end;
  Writeln(ExportFile, '};');
  CloseFile(ExportFile);

end;

end.
