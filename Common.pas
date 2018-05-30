unit Common;
//for variables that need to be accessed from multiple forms
interface
uses
  Vcl.Graphics, System.Classes;
type
  TCommon = class
    procedure Redraw();
    procedure DrawTile(tileX, tileY: Integer);
  end;
  TTile = array[0..8, 0..8] of Byte;
  TPalette = array[0..3] of TColor;

var
  Palettes: array [0..15] of TPalette;
  TileMap: array of array of TTile;
  PaletteIndexes: array of array of Integer;
implementation
  uses Main;

procedure TCommon.Redraw();
var i, j: Integer;
begin
  Main.Editor.TilesImage.Canvas.Brush.Color := clWhite;
  Main.Editor.TilesImage.Canvas.FillRect(Rect(0,0,Main.Editor.TilesImage.Width,Main.Editor.TilesImage.Height));
  for j := 0 to NumTilesY - 1 do
    for i := 0 to NumTilesX - 1 do
      DrawTile(i, j);
  Main.Editor.TilesImage.Canvas.Pen.Color := clBlack;
  if Main.Editor.ShowGrid.Checked then
  begin
    for i := 1 to NumTilesX - 1 do
    begin
      Main.Editor.TilesImage.Canvas.MoveTo(i * PIXELS_PER_TILE * ScalingFactor + (i-1), 0);
      Main.Editor.TilesImage.Canvas.LineTo(i * PIXELS_PER_TILE * ScalingFactor + (i-1),
        Main.Editor.TilesImage.Height);
    end;
    for i := 1 to NumTilesY - 1 do
    begin
      Main.Editor.TilesImage.Canvas.MoveTo(0, i * PIXELS_PER_TILE * ScalingFactor + (i-1));
      Main.Editor.TilesImage.Canvas.LineTo(Main.Editor.TilesImage.Width,
        i * PIXELS_PER_TILE * ScalingFactor + (i-1));
    end;
  end;

end;

procedure TCommon.DrawTile(tileX: Integer; tileY: Integer);
var i, j: Integer;
begin
 for j := 0 to PIXELS_PER_TILE - 1 do
  for i := 0 to PIXELS_PER_TILE - 1 do
  begin
    Main.Editor.TilesImage.Canvas.Brush.Color := Palettes[PaletteIndexes[tileX, tileY]][TileMap[tileX, tileY][i, j]];
    if Main.Editor.ShowGrid.Checked then //leave spaces so grid doesn't overwrite image
      Main.Editor.TilesImage.Canvas.FillRect(Rect((tileX * PIXELS_PER_TILE + i) * ScalingFactor + tileX,
      (tileY * PIXELS_PER_TILE + j) * ScalingFactor + tileY,
      (tileX * PIXELS_PER_TILE + i + 1) * ScalingFactor + tileX,
      (tileY * PIXELS_PER_TILE + j + 1) * ScalingFactor + tileY))
    else
      Main.Editor.TilesImage.Canvas.FillRect(Rect((tileX * PIXELS_PER_TILE + i) * ScalingFactor,
      (tileY * PIXELS_PER_TILE + j) * ScalingFactor,
      (tileX * PIXELS_PER_TILE + i + 1) * ScalingFactor,
      (tileY * PIXELS_PER_TILE + j + 1) * ScalingFactor));
  end;
end;

end.
