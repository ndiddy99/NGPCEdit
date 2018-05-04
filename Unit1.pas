unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Menus,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Samples.Spin;

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
    procedure DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ScalingSpinChange(Sender: TObject);
    procedure XSpinChange(Sender: TObject);
    procedure YSpinChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  POSSIBLE_COLORS : array [0..3] of TColor = (clWhite, clLtGray, clDkGray, clBlack);
  PIXELS_PER_TILE = 8;
  GRID_PADDING = 20; //num of pixels to pad out grid by
  MAX_WINDOW_WIDTH = 800;  //max size window "auto resizes" to
  MAX_WINDOW_HEIGHT = 600;
var
  Editor: TEditor;
  isDrawing: Boolean;
  currColor: Integer; //current color (1=black, 4=white)
  scalingFactor: Integer;
  numPixelsX, numPixelsY: Integer;
  PixelMap: array of array of Integer;

implementation

{$R *.dfm}

procedure TEditor.FormCreate(Sender: TObject); //init procedure
begin
  currColor := 0;
  scalingFactor := 40;
  ScalingSpin.Value := 40;
  numPixelsX := 8;
  numPixelsY := 8;
  SetLength(PixelMap, numPixelsX, numPixelsY);
end;



procedure TEditor.ScalingSpinChange(Sender: TObject);
begin
  scalingFactor := ScalingSpin.Value;
  DrawGrid1.DefaultColWidth := scalingFactor;
  DrawGrid1.DefaultRowHeight := scalingFactor;
  if ScalingSpin.Value <> 40 then
  begin
    DrawGrid1.Width := numPixelsX*scalingFactor + numPixelsX * GRID_PADDING;
    DrawGrid1.Height := numPixelsY*scalingFactor + numPixelsY * GRID_PADDING;
  end;

//  DrawGrid1.Invalidate;
end;

procedure TEditor.XSpinChange(Sender: TObject);
begin
  numPixelsX  := XSpin.Value * PIXELS_PER_TILE;
  SetLength(PixelMap, numPixelsX, numPixelsY);
  DrawGrid1.ColCount := numPixelsX;
  DrawGrid1.Width := numPixelsX*scalingFactor +XSpin.Value * GRID_PADDING;
  DrawGrid1.Invalidate;
end;

procedure TEditor.YSpinChange(Sender: TObject);
begin
  numPixelsY := YSpin.Value * PIXELS_PER_TILE;
  SetLength(PixelMap, numPixelsX, numPixelsY);
  DrawGrid1.RowCount := numPixelsY;
  DrawGrid1.Height := numPixelsY*scalingFactor + YSpin.Value * GRID_PADDING;
  DrawGrid1.Invalidate;
end;

procedure TEditor.Color1Click(Sender: TObject);
begin
  currColor := 0;
end;

procedure TEditor.Color2Click(Sender: TObject);
begin
  currColor := 1;
end;

procedure TEditor.Color3Click(Sender: TObject);
begin
  currColor := 2;
end;

procedure TEditor.Color4Click(Sender: TObject);
begin
  currColor := 3;
end;

procedure TEditor.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawGrid1.Canvas.Brush.Color := POSSIBLE_COLORS[PixelMap[ACol,ARow]];
  DrawGrid1.Canvas.FillRect(Rect);
end;

procedure TEditor.DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  PixelMap[ACol,ARow]:=currColor;
  DrawGrid1.Invalidate;
end;

procedure TEditor.Exit1Click(Sender: TObject);
begin
  Editor.Close;
end;
end.
