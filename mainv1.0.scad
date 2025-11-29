/**
* Mandala Generator
*
* Sourcecode: git@github-veryos:veryos-git/openscad_stargen_v3.git
* Author: veryos  
* Version: 1.0
*
* Description:
* This OpenSCAD script generates a 3d object that is ornamental mandala like.
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
* Changelog:
* [v1.0] Initial release
*/

height = 50; 
//radius at top (normalized)
r_top = 0; // [0.01:1.0]
//radius at bottom (normalized)
r_bottom = 0.2; // [0.01:1.0]

// same as in slicer
layerheight = 0.2; // [0.12,0.16,0.2,0.24,0.28]

height_trunk = 10; // [0.01:1.0]
radius_trunk = 5; // [0.01:1.0]

// absolute
branches_on_layer = 3; // [1:20]

// 50 -> each 2nd layer has branches
percentage_layers_with_branches = 50; // [0:1.0:100]

// 2.0 -> branches are double as long as radius of current layer
branch_length = 2.0;//  [1:0.1:5.0]

// 0.2 => branch has same height as default layer
branch_height = 0.2; // [0.01:2.0]
// 0.42 => branch is one extrusion width line thick
branch_thick = 0.42; // [0.01:2.0]

// golden angle for optimal distribution
angle_per_branch = 137.5; // [0:360]


// make a cylinder with bottom diameter radiusmax*2 and top diameter radiusmin*2
radius_top = r_top*height;
radius_bottom = r_bottom*height;
radius_delta = radius_bottom - radius_top;
cylinder(h = height, r1 = radius_bottom, r2 = radius_top, center = false, $fn=160);

nor_branches_on_tree = (percentage_layers_with_branches / 100); 

layerswithbranches = (height/layerheight)*nor_branches_on_tree;
trn_z_per_branchlayer = height / layerswithbranches;
for(i = [0 : layerswithbranches - 1]) {
    for(j = [0 : branches_on_layer - 1]) {

        let(
            trn_z =  i * trn_z_per_branchlayer,
            it_nor = i / layerswithbranches,
            rotation = ((j*branches_on_layer)+i) *angle_per_branch,
            radius = ((1-it_nor)*radius_bottom*branch_length*2)+radius_top,
        ){
            translate([-branch_thick/2, 0, trn_z])
            rotate([0, 0, rotation])
            cube([branch_thick, radius, branch_height], center = true);
        }
    }
}

// add trunk cylinder
trn_z_offset = height_trunk; 
translate([0,0,-trn_z_offset])
cylinder(h = height_trunk, r = radius_trunk, center = false, $fn=160);