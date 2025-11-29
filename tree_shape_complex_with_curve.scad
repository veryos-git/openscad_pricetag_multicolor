// control points (x,y) — your input
// Add or remove points as needed - the spline adapts automatically


// i am not enought of a mathematician to understand this code fully :) but it creates a nice curved shape

/* [ Shape ] */
d1 = 0.9; // [0:0.01:1]
d2 = .7;  // [0:0.01:1]
d3 = .5; // [0:0.01:1]
d4 = .3; // [0:0.01:1]
d5 = .1; // [0:0.01:1]

height = 5; 
maxwidth = 1;
points = [
    [0,0],     // bottom edge
    [d1,1],
    [d2,2],
    [d3,3],
    [d4,4],
    [d5,5],
    [0,6],     // top edge
];

steps = 1*12;    // points per segment (increase for smoother curve)
$fn = 1*160;     // resolution for the revolve (increase for smoother surface)

// helper: safe index (clamp endpoints)
function pt(i, pts) = pts[i < 0 ? 0 : (i >= len(pts) ? len(pts)-1 : i)];

// 1D Catmull-Rom basis
function cr1(a,b,c,d,t) =
    0.5 * ( 2*b + (-a + c)*t + (2*a - 5*b + 4*c - d)*t*t + (-a + 3*b - 3*c + d)*t*t*t );

// 2D Catmull-Rom point
function cr_point(p0,p1,p2,p3,t) =
    [ cr1(p0[0],p1[0],p2[0],p3[0],t), cr1(p0[1],p1[1],p2[1],p3[1],t) ];

// build the full interpolated polyline through all control points
function spline(pts, steps) =
    concat(
        // for each segment between pts[i] and pts[i+1], sample 'steps' points
        [ for (i=[0:len(pts)-2])
            for (s=[0:steps-1])
                cr_point(
                    pt(i-1, pts),
                    pt(i,   pts),
                    pt(i+1, pts),
                    pt(i+2, pts),
                    s / steps
                )
        ],
        // ensure last control point is included
        [ pts[len(pts)-1] ]
    );

// create profile and revolve around Z axis, then cut flat top and bottom
difference() {
    rotate([0,0,0])
        rotate_extrude()
            polygon(spline(points, steps));
    

}

ch = 5;
csize = 10;
color(c=[0.2, 0.4, 0.4], alpha=0.2) 
// cut bottom
translate([-csize/2, -csize/2, -ch+1])
    cube([csize,csize,ch]);


    // Axis helpers
axis_length = 2;
axis_width = 0.5;

// X axis - red
color("red") 
    translate([axis_length/2, 0, 0])
        cube([axis_length, axis_width, axis_width], center=true);

// Y axis - green
color("green") 
    translate([0, axis_length/2, 0])
        cube([axis_width, axis_length, axis_width], center=true);

// Z axis - blue
color("blue") 
    translate([0, 0, axis_length/2])
        cube([axis_width, axis_width, axis_length], center=true);

// Origin marker - yellow sphere
color("yellow") 
    sphere(r=1, $fn=20);
