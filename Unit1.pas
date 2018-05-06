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
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure Color2Click(Sender: TObject);
    procedure Color3Click(Sender: TObject);
    procedure Color4Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
//    procedure DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
//      var CanSelect: Boolean);
    procedure ScalingSpinChange(Sender: TObject);
    procedure XSpinChange(Sender: TObject);
    procedure YSpinChange(Sender: TObject);
    procedure DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DrawGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawGrid1MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  POSSIBLE_COLORS : array [0..3] of TColor = (clWhite, clLtGray, clDkGray, clBlack);
  PIXELS_PER_TILE = 8;
  GRID_PADDING = 12; //num of pixels to pad out grid by
  WINDOW_X_PADDING = 40;
  WINDOW_Y_PADDING = 120;
  MIN_WINDOW_WIDTH = 600;
  MIN_WINDOW_HEIGHT = 379;
  MAX_GRID_WIDTH = 800;
  MAX_GRID_HEIGHT = 600;
var
  Editor: TEditor;
  CurrColor: Integer; //current color (1=black, 4=white)
  ScalingFactor: Integer;
  NumPixelsX, NumPixelsY: Integer;
  PixelMap: array of array of Integer;
  IsDrawing: Boolean;

implementation

{$R *.dfm}

procedure TEditor.FormCreate(Sender: TObject); //init procedure
begin
  CurrColor := 0;
  ScalingFactor := 40;
  ScalingSpin.Value := 40;
  NumPixelsX := 8;
  NumPixelsY := 8;
  IsDrawing := False;
  SetLength(PixelMap, NumPixelsX, NumPixelsY);
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
  NumPixelsX := XSpin.Value * PIXELS_PER_TILE;
  SetLength(PixelMap, NumPixelsX, NumPixelsY);
  DrawGrid1.ColCount := NumPixelsX;
  if NumPixelsX*ScalingFactor + XSpin.Value * GRID_PADDING < MAX_GRID_WIDTH then
    DrawGrid1.Width := NumPixelsX*ScalingFactor + XSpin.Value * GRID_PADDING
  else
    DrawGrid1.Width := MAX_GRID_WIDTH;
  DrawGrid1.Invalidate;
  Editor.Width := Max(DrawGrid1.Width + WINDOW_X_PADDING, MIN_WINDOW_WIDTH);
end;

procedure TEditor.YSpinChange(Sender: TObject);
begin
  NumPixelsY := YSpin.Value * PIXELS_PER_TILE;
  SetLength(PixelMap, NumPixelsX, NumPixelsY);
  DrawGrid1.RowCount := NumPixelsY;
  if NumPixelsY*ScalingFactor + YSpin.Value * GRID_PADDING < MAX_GRID_HEIGHT then
    DrawGrid1.Height := NumPixelsY*ScalingFactor + YSpin.Value * GRID_PADDING
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
begin
  DrawGrid1.Canvas.Brush.Color := POSSIBLE_COLORS[PixelMap[ACol,ARow]];
  DrawGrid1.Canvas.FillRect(Rect);
end;

procedure TEditor.DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PixelMap[(X - DrawGrid1.Left) div ScalingFactor, Y div ScalingFactor] := CurrColor;
  IsDrawing := True;
  DrawGrid1.Invalidate;
end;

procedure TEditor.DrawGrid1MouseLeave(Sender: TObject);
begin
  IsDrawing := False;
end;

procedure TEditor.DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  XArrIndex, YArrIndex: Integer;
begin
  XArrIndex := (X - DrawGrid1.Left) div ScalingFactor;
  YArrIndex := Y div ScalingFactor;
  if IsDrawing and (XArrIndex < NumPixelsX) and (YArrIndex < NumPixelsY) then
    begin
        PixelMap[(X - DrawGrid1.Left) div ScalingFactor, Y div ScalingFactor] := CurrColor;
        DrawGrid1.Invalidate;
    end;
end;

procedure TEditor.DrawGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsDrawing := False;
end;

//procedure TEditor.DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
//  var CanSelect: Boolean);
//begin
//  PixelMap[ACol,ARow] := CurrColor;
//  DrawGrid1.Invalidate;
//end;

procedure TEditor.Exit1Click(Sender: TObject);
begin
  Editor.Close;
end;
end.
