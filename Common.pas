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
end;

procedure TCommon.DrawTile(tileX: Integer; tileY: Integer);
var i, j: Integer;
begin
 for j := 0 to PIXELS_PER_TILE - 1 do
  for i := 0 to PIXELS_PER_TILE - 1 do
  begin
    Main.Editor.TilesImage.Canvas.Brush.Color := Palettes[PaletteIndexes[tileX, tileY]][TileMap[tileX, tileY][i, j]];
    Main.Editor.TilesImage.Canvas.FillRect(Rect((tileX * PIXELS_PER_TILE + i) * ScalingFactor,
    (tileY * PIXELS_PER_TILE + j) * ScalingFactor,
    (tileX * PIXELS_PER_TILE + i + 1) * ScalingFactor,
    (tileY * PIXELS_PER_TILE + j + 1) * ScalingFactor));
  end;
end;

end.
