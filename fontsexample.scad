
// this is an example for custom text in openscad 
// as a reference this can be used too https://makerworld.com/en/makerlab/parametricModelMaker?designId=1848246&from=model_page&modelName=Stacked+Name+Tag+-+3+Levels+.scad&protected=true&unikey=bad92ae8-ebf9-4304-8988-12b06de90041

Font_name = "Aladin"; //     [Aladin, Aldo, Akronim, Audiowide, Bangers, Bebas Neue, Bubblegum Sans, Changa One, Dancing Script, Damion, DynaPuff, Gochi Hand, Great Vibes, Griffy, Indie Flower, Lobster, Luckiest Guy, Mitr, Nanum Pen, New Rocker, Orbitron, Pacifico, Passion One, Permanent Marker, Pixelify Sans, PoetsenOne, Rubik Moonrocks, Rubik Wet Paint, Saira Stencil One, Sacramento, Shrikhand, Spicy Rice, Titan One, Trade Winds]
// not all styles work for every font type
font_style = ""; //  [Regular ,Bold , Italic , Bold Italic]
font_name_full = str(Font_name, ":style=", font_style);

// fonts wont work in https://ochafik.com/openscad2
include <BOSL2/std.scad>;
txt = "The quick brown fox jumps over the lazy dog.";
linear_extrude(height = 20)
    text(text = txt, size = 20, halign = "left", valign = "top", font = font_name_full);

translate([0,30, 0])
text3d(txt, h=20, size=20, font = font_name_full, anchor=CENTER, atype="ycenter");