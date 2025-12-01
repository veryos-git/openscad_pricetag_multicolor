/**
* Mandala Generator
*
* Sourcecode: git@github-veryos:veryos-git/openscad_stargen_v3.git
* Author: veryos  
* Version: 1.0
*
* Description:
* This OpenSCAD script generates a 3d object is a tiny house
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
* 
* https://ochafik.com/openscad2
*
* Changelog:
* [v1.0] Initial release
*/


// proxying the parameters
housewidth = 20;
housedepth = 30; 
househeight = 25;
roofheight = 10;
thicknesswall = 2;

a = housewidth; 
l = housedepth;
b = househeight;

c = roofheight; 
tw = thicknesswall;


// Axis helper for orientation
module axis_helper(size = 5) {
    // X axis - Red
    color("red") 
        translate([0, 0, 0]) 
        rotate([0, 90, 0]) 
        cylinder(h = size, r = 0.1, $fn = 8);
    
    // Y axis - Green
    color("green") 
        translate([0, 0, 0]) 
        rotate([90, 0, 0]) 
        cylinder(h = size, r = 0.1, $fn = 8);
    
    // Z axis - Blue
    color("blue") 
        translate([0, 0, 0]) 
        cylinder(h = size, r = 0.1, $fn = 8);
}

axis_helper(5);


module window(
    w, 
    h,
    t, 
    t2 // fenstersprossen / window mountins / window gridbars  
){
    let(
        rows = 2, 
        cols = 2, 
        pane_width = (w - (t2*(cols+1)))/cols,
        pane_height = (h - (t2*(rows+1)))/rows
    ){
        difference(){
            // window frame
            cube([w, h, t]);

            // cut out the glass panes
            for(i = [0 : cols - 1]){
                for(j = [0 : rows - 1]){
                    translate([t2 + i*(t2+pane_width), t2 + j*(t2+pane_height), -t])
                        cube([pane_width, pane_height, t*3]);
                }
            }
            
        }
    }
}
window(3, 5, .5, 0.5);