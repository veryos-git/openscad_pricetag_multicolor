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
househeight = 30;
sidewallwidth = 30; 

thicknesswall = 1.2;
roofheight = 15;

/* [windows front] */
window_cols_front = 2;
window_rows_front = 2;
window_width_front = 6; 
window_height_front = 8;
window_mountins_front = 0.6;
window_distance_front_x = 2;
window_distance_front_y = 2;
radius_round_window = 2.5;
window_mountins_round = 0.6;


/* [windows side] */
window_cols_side = 3;
window_rows_side = 2;
window_width_side = 6; 
window_height_side = 8;
window_mountins_side = 0.6;
window_distance_side_x = 2;
window_distance_side_y = 2;

/* [windows roof] */
window_cols_roof = 3;
window_rows_roof = 1;
window_width_roof = 4; 
window_height_roof = 6;
window_mountins_roof = 0.6;
window_distance_roof_x = 2;
window_distance_roof_y = 2;


sidewallheight = househeight;



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



module windowholes(
    w, 
    h,
    scl_z, 
    t2 // fenstersprossen / window mountins / window gridbars  
){
    let(
        rows = 2, 
        cols = 2, 
        pane_width = (w - (t2*(cols+1)))/cols,
        pane_height = (h - (t2*(rows+1)))/rows, 
    ){

        for(i = [0 : cols - 1]){
            for(j = [0 : rows - 1]){
                translate([
                    -w/2 + t2 + pane_width/2 + i*(t2+pane_width), 
                    -h/2 + t2 + pane_height/2 + j*(t2+pane_height), 
                    0
                ])
                    cube([pane_width, pane_height, scl_z*3], center = true);
            }
        }
    }
}
module window(
    w, 
    h,
    scl_z, 
    t2 // fenstersprossen / window mountins / window gridbars  
){

    difference() {
        cube([w, h, scl_z], center = true);
        windowholes(w, h, scl_z, t2);
    }
}
module windowholesgrid(
    cols =2, 
    rows =2,
    trnx = 1, 
    trny = 1, 
    w, 
    h,
    t, 
    t2 // fenstersprossen / window mountins / window gridbars
){
    let(
        total_width = cols * w + (cols - 1) * trnx,
        total_height = rows * h + (rows - 1) * trny
    ){
        for(i = [0 : cols - 1]){
            for(j = [0 : rows - 1]){
                translate([
                    -total_width/2 + w/2 + i*(trnx + w), 
                    -total_height/2 + h/2 + j*(trny + h), 
                    0
                ])
                    windowholes(w, h, t, t2);
            }
        }
    }
}
// window(3, 5, .5, 0.5);

module wallfront(
    w, 
    h, 
    scl_z, 
    w_window, 
    h_window, 
    windowmountins = 0.5,
    cols = 2, 
    rows = 2, 
    trnx = 1, 
    trny = 1,
){

    difference() {
        cube([w, h, scl_z], center = true);
        windowholesgrid(
            cols =cols, 
            rows =rows,
            //the windows should be equally spread 
            trnx = trnx, 
            trny = trny,
            w=w_window, 
            h=h_window,
            t=scl_z, 
            t2 = windowmountins // fenstersprossen / window mountins / window gridbars
        );
    }
    

}

module circularwindowholes(
    radius,
    depth,
    t2 = 0.5 // fenstersprossen / window mountins / window gridbars
){
    // cylinder and subtract some crossed lines/cubes from it
    difference(){
        // main circular window hole
        cylinder(h = depth, r = radius, center = true, $fn=64);
        
        // horizontal crossbar
        cube([radius*2, t2, depth*3], center = true);
        
        // vertical crossbar
        cube([t2, radius*2, depth*3], center = true);
    }
}

module cubewithcircularedges(w, h, d, fn=16, center=true){
    //if center is true, center the cube
    let (
        tw = (center) ? -w/2 : 0, 
        th = (center) ? -h/2 : 0, 
        td = (center) ? -d/2 : 0
    ){

      translate([tw,th,td])
        union(){
            cube([w, h, d]);
            translate([0, 0, d/2])
            sphere(r = d/2, $fn = fn);
            translate([w, 0, d/2])
            sphere(r = d/2, $fn = fn);
            translate([w, h, d/2])
            sphere(r = d/2, $fn = fn);
            translate([0, h, d/2])
            sphere(r = d/2, $fn = fn);
            translate([0, 0, d/2])
            rotate([0,90,0])
            cylinder(h = w, r = d/2, $fn = fn);
            translate([0, h, d/2])
            rotate([0,90,0])
            cylinder(h = w, r = d/2, $fn = fn);
            translate([0, 0, d/2])
            rotate([0,90,90])
            cylinder(h = h, r = d/2, $fn = fn);
            translate([w, 0, d/2])
            rotate([0,90,90])
            cylinder(h = h, r = d/2, $fn = fn);

        }
    }
}
module rooftriangle(
    basewidth, 
    height, 
    thicknesswall
){
    // main triangle prism
    // translate([-basewidth/2, -height/2, 0])
    translate([-basewidth/2, -height/2, -thicknesswall/2])
    linear_extrude(height = thicknesswall)
        polygon(points = [
            [0, 0], 
            [basewidth, 0], 
            [basewidth/2, height]
        ]);
    
}
module roof(
    basewidth, 
    height, 
    thicknesswall, 
    radiuswindow, 
    mountinswidth = 0.5
){
  difference(){
    rooftriangle(basewidth=basewidth, height=height, thicknesswall=thicknesswall);
    circularwindowholes(radiuswindow, depth=thicknesswall*3, t2=mountinswidth);
  }
}
// window(10, 20, 0.5, 0.5);
// windowholes(10, 20, 0.5, 0.5);

// wallfront(20, 30, 1, 3, 5, 0.4);

// circularwindowholes(5, 2, 0.5);

// rooftriangle(20, 10, 2);

// roof(20, 10, 2, 2);
//cubewithcircularedges(10, 20, 2);
module housefront(){
    wallfront(
        housewidth, 
        househeight, 
        thicknesswall, 
        window_width_front, 
        window_height_front, 
        window_mountins_front,
        cols =window_cols_front, 
        rows =window_rows_front,
        trnx = window_distance_front_x,
        trny = window_distance_front_y
    );
    translate([
        0,
        (roofheight/2)+(househeight/2),
        0
    ])
    roof(
        housewidth, 
        roofheight, 
        thicknesswall, 
        radius_round_window,
        window_mountins_round
    );
}
module househalf(){
    housefront();

    // house side wall
    rotate([0,90,0])
    translate(
      [
        sidewallwidth/2-thicknesswall/2,
        0,
        housewidth/2,//sidewallheight/2-thicknesswall
    ])
    wallfront(
        sidewallwidth, 
        sidewallheight, 
        thicknesswall, 
        window_width_side, 
        window_height_side, 
        window_mountins_side,
        cols =window_cols_side, 
        rows =window_rows_side,
        trnx = window_distance_side_x,
        trny = window_distance_side_y
    );

    translate([
        housewidth/2,
        househeight/2,
        thicknesswall/2
    ])

    rotate([0,90,0])

    //calculate rotation of roof
    rotate([
        -atan((housewidth/2) / roofheight), 
        0, 
        0
    ])
    difference(){
        let(
            roofpartlength = sqrt((roofheight*roofheight) + ((housewidth/2)*(housewidth/2)))
        ){

            cubewithcircularedges(
                sidewallwidth, 
                //calculate roof sidelength
                roofpartlength,
                thicknesswall,
                16,
                false
            );
            translate([sidewallwidth/2, roofpartlength/2 , 0])
                windowholesgrid(
                    
                    cols =window_cols_roof, 
                    rows =window_rows_roof,
                    //the windows should be equally spread 
                    trnx = window_distance_roof_x, 
                    trny = window_distance_roof_y,
                    w=window_width_roof, 
                    h=window_height_roof,
                    t=thicknesswall, 
                    t2 = window_mountins_roof // fenstersprossen / window mountins / window gridbars
                );
        }
    }


}
module housenobase(){
  househalf();
  mirror([1,0,0])
  househalf();
  translate([0,0,-sidewallwidth+thicknesswall])
  housefront();
}


module housebase(){
  housenobase();
 
  //if housebase is bigger than 40x40, we cut out a cylinder for a led tealight
    if(housewidth > 40 && sidewallwidth > 40){
        difference(){
            translate([-housewidth/2, -househeight/2,-sidewallwidth+thicknesswall])
            cube([housewidth, thicknesswall, sidewallwidth-thicknesswall]);
            translate([0, -househeight/2,-housewidth/2])
            rotate([90,0,0])
            cylinder(h = 22, r = 20, $fn=64, center=true);
        }
    }else{
        translate([-housewidth/2, -househeight/2,-sidewallwidth+thicknesswall])
        cube([housewidth, thicknesswall, sidewallwidth-thicknesswall]);

    }
}

rotate([90,0,0])
housebase();



// base 

// axis_helper(5);
// cubewithcircularedges(10,20,2,16, true );
