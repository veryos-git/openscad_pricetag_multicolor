/**
 * Star Generator
 *
 * Sourcecode: git@github.com:veryos-git/openscad_size_reference_objects.git
 * Author: veryos  
 * Version: 1.0
 *
 * Description:
 * This OpenSCAD script generates a price tag for a bakery or cafe. The text can be customized.
 *
 * License:
 *    Licensed under the GNU General Public License v3.0 or later.
 *    See the LICENSE.txt file in the repository root for details.
 *
 * Opensource credits:
 * - openscad 'language': https://openscad.org/ 
 * - online openscad playground: https://ochafik.com/openscad2
 * - free image editor : https://rawtherapee.com/
 * - free source code hosting: https://github.com/
 * - online photo collage: https://pixlr.com/photo-collage/
 * - thumbnail designer: https://tools.datmt.com/tools/thumb-maker
 * - BOSL2 library: https://github.com/BelfrySCAD/BOSL2/wiki/shapes3d.scad#module-cuboid
 * 
 * Changelog:
 * [v1.0] Initial release
 */


//wont work in makerworld
//include <BOSL/constants.scad>
//use <BOSL/shapes.scad>

//using BOSL2 for makerworld compatibility
include <BOSL2/std.scad>;

// text_1 = "Schifffahrtsgesellschaft";


/* [text line 1] */
text_1 = "Cherry"; // todo , see if emoji icon can be used 🍰
text_1_size = 8;
text_1_alignment_horizontal = "left"; // [left, center, right]


/* [text line 2] */
text_2 = "Cake";
text_2_size = 8;
text_2_alignment_horizontal = "left"; // [left, center, right]


/* [text line 3] */
text_3 = "5$";
text_3_size = 8;
text_3_alignment_horizontal = "right"; // [left, center, right]

/* [text] */
font_type = "Overpass"; //     [Overpass,Aladin, Aldo, Akronim, Audiowide, Bangers, Bebas Neue, Bubblegum Sans, Changa One, Dancing Script, Damion, DynaPuff, Gochi Hand, Great Vibes, Griffy, Indie Flower, Lobster, Luckiest Guy, Mitr, Nanum Pen, New Rocker, Orbitron, Pacifico, Passion One, Permanent Marker, Pixelify Sans, PoetsenOne, Rubik Moonrocks, Rubik Wet Paint, Saira Stencil One, Sacramento, Shrikhand, Spicy Rice, Titan One, Trade Winds]

// may not work for every font style
font_style = "Regular"; //  [Regular ,Bold , Italic , Bold Italic]
font_name_full = str(font_type, ":style=", font_style);

/* [plate] */
width = 50; 
height = 30;
// angle of the stand
angle = 50; 
thickness = 3;
thickness_stand = 1.2;
// should be a multiple of layerheight (3*0.2=0.6)
text_backlayer_thickness = 2.4;

// the height is the hypotenuse base of the triangle
// the heigh2 should be the kathete height of the triangle
height2 = height*cos(angle)+5;

stolzfight = 1.0* 0.01;


text_1_anchor = 
    text_1_alignment_horizontal == "left" ? LEFT :
    text_1_alignment_horizontal == "center" ? CENTER :
    text_1_alignment_horizontal == "right" ? RIGHT :
    CENTER;

text_2_anchor = 
    text_2_alignment_horizontal == "left" ? LEFT :
    text_2_alignment_horizontal == "center" ? CENTER :
    text_2_alignment_horizontal == "right" ? RIGHT :
    CENTER;
text_3_anchor = 
    text_3_alignment_horizontal == "left" ? LEFT :
    text_3_alignment_horizontal == "center" ? CENTER :
    text_3_alignment_horizontal == "right" ? RIGHT :
    CENTER;

text_padding_left = 3;
text_padding_right = 3;
text_padding_top = 2;
text_padding_bottom = 2;

text_1_x_translation = 
    text_1_alignment_horizontal == "left" ? -width/2 + text_padding_left :
    text_1_alignment_horizontal == "center" ? 0 :
    text_1_alignment_horizontal == "right" ? width/2 - text_padding_right :
    0;
text_2_x_translation = 
    text_2_alignment_horizontal == "left" ? -width/2 + text_padding_left :
    text_2_alignment_horizontal == "center" ? 0 :
    text_2_alignment_horizontal == "right" ? width/2 - text_padding_right :
    0;
text_3_x_translation = 
    text_3_alignment_horizontal == "left" ? -width/2 + text_padding_left :
    text_3_alignment_horizontal == "center" ? 0 :
    text_3_alignment_horizontal == "right" ? width/2 - text_padding_right :
    0;

// Width of the border around the text (in mm)
text_border_width = 0.4;


module text_lines(offset_amount = 0){
    let(
        hpadding = height - text_padding_top - text_padding_bottom,
        trn_y = hpadding/3
    ){
        translate([0, height/2-text_padding_top, 0])

        union(){
            
            translate([text_1_x_translation, -0*trn_y-(trn_y/2), text_backlayer_thickness])
            if (offset_amount > 0) {
                offset3d(offset_amount)
                text3d(text_1, h=thickness, size=text_1_size, font = font_name_full, anchor=text_1_anchor, atype="ycenter");
            } else {
                text3d(text_1, h=thickness, size=text_1_size, font = font_name_full, anchor=text_1_anchor, atype="ycenter");
            }
            
            translate([text_2_x_translation, -1*trn_y-(trn_y/2), text_backlayer_thickness])
            if (offset_amount > 0) {
                offset3d(offset_amount)
                text3d(text_2, h=thickness, size=text_2_size, font = font_name_full, anchor=text_2_anchor, atype="ycenter");
            } else {
                text3d(text_2, h=thickness, size=text_2_size, font = font_name_full, anchor=text_2_anchor, atype="ycenter");
            }
            
            translate([text_3_x_translation, -2*trn_y-(trn_y/2), text_backlayer_thickness])
            if (offset_amount > 0) {
                offset3d(offset_amount)
                text3d(text_3, h=thickness, size=text_3_size, font = font_name_full, anchor=text_3_anchor, atype="ycenter");
            } else {
                text3d(text_3, h=thickness, size=text_3_size, font = font_name_full, anchor=text_3_anchor, atype="ycenter");
            }
        }
    }
}

module textplate(){

    union(){
        
        difference(){

            cuboid([width, height, thickness], rounding=thickness/4);

            // Cut out text with offset to create border
            text_lines(text_border_width);
        }
        
        // Add back the text without offset (creating the border effect)
        text_lines(0);
    }
}

module textplate_with_stand(){

    difference(){

        difference(){

            union(){
  
                difference(){

                translate([0,0,-thickness_stand])
                    rotate([angle, 0, 0])
                    difference(){
                        translate([0, height/2,-thickness_stand/2])
                        textplate();
                        
                    }
                    translate([0,0,-thickness])
                    cuboid([width*2, height*2, 4]);
                }
                translate([0, height2/2-thickness_stand/2, -thickness_stand/2])
                cuboid([width, height2, thickness_stand], rounding=thickness_stand/4);
            
            }


        }
        rotate([angle, 0, 0])
        translate([0,0,thickness/2])
        cuboid([width*2, height*2, thickness]);


    }

}



textplate_with_stand();

translate([width+10, 0, -thickness_stand])
union(){
    rotate([90+(90-angle),0,0])
    textplate_with_stand();
    // translate([-30,-70,0])
    // cube([60,10,1]);
    // translate([-20,0,0])
    // color([1,0,0])
    // text3d("print like this ^", h = 2, size = 5, anchor = LEFT, atype="ycenter");
}



// color([1,0,0])
// sphere(r=10);