$fs=1;   // fragment length for circle
d=0.01;  // delta for extra cut

kd=19;  // key distance
cw=14;  // chamber width
ch=7.5;  // chamber height

mpt=1.5; // mount plate thickness
chw=5;   // clip hole width
chh=2;   // clip hole height
chd=0.6; // clip hole depth

thw=3.0; // teensy house width

module teensy(x,y,z) {
  tl=36;  // teensy length
  tw=18;  // teensy width
  th=4;   // teensy height
  tbh=1;  // teensy board height
  tcl=6;  // teensy connector length
  tcw=8;  // teensy connector width
  tch=3;  // teensy connector height

  translate([x*kd, y*kd, z*kd]) rotate([0,90,180]) {
    color("green") cube([tbh,tl,tw]);
    color("white") translate([tbh,-1,tw/2-tcw/2]) cube([tch,tcl,tcw]);
  }
}

module case(left=false) {
  border = 2.5;
  length = 6.3*kd;
  width = 5.7*kd;
  x_shift = 0.5*cw;
  y_shift = 1.3*cw;
  corner = 20;
  wiring_hole = 6;
  support_width = 3.5;
  sink_unit = 1;
  thickness = 5;
  fastner_shift = 8.5;
  screw_radius = 0.8+0.4;
  nut_radius = 2.0+0.4;

  key_pos = [
    [5.3,1.5,1,-1,0],[5.4,2.5,1,0,0],[5.5,3.5,1,3,0],[5.4,4.5,1,2,0],[5.3,5.5,1,0,0],
    [4.3,1.5,1,-1,0],[4.4,2.5,1,0,0],[4.5,3.5,1,3,0],[4.4,4.5,1,2,0],[4.3,5.5,1,0,0],
    [3.3,1.5,1,-1,0],[3.4,2.5,1,0,0],[3.5,3.5,1,3,0],[3.4,4.5,1,2,0],[3.3,5.5,1,0,0],
    [2.3,1.5,1,-1,0],[2.4,2.5,1,0,0],[2.5,3.5,1,3,0],[2.4,4.5,1,2,0],[2.3,5.5,1,0,0],
                                     [1.5,3.5,1,1,0],[1.4,4.5,1,0,0],[1.3,5.5,1,-2,0],
    //[-0.04,0.60,1,1.5,45],[0.66,1.35,1,1.75,30],[1.15,2.25,1,2,15],
    [0.23,0.48,1,0,35],[0.79,1.325,1,0,25],[1.20,2.25,1,0,15],
    //[0.375,0.365,1,0,30],[0.87,1.27,1,0,20],[1.20,2.25,1,0,10],
  ];
  screws = [
    [fastner_shift - 4, fastner_shift + 6],
    //[fastner_shift - 5, fastner_shift + 8],
    [fastner_shift - 4, width - fastner_shift - 6],
    [length - fastner_shift - 8, width - fastner_shift + 5],
    [length - fastner_shift - 8, fastner_shift - 5],
  ];

  module key(row,col,size,sink=0,angle=0) {
    translate([kd*(col+(size-1)/2)+border,kd*row+border,-sink*sink_unit-d]) {
      rotate([0,0,angle]) {
        translate([-(kd-cw)/2,-(kd-cw)/2,thickness+d]) cube([kd+d,kd+d,sink*sink_unit+d*2]);
        translate([0,0,-10]) cube([cw,cw,20]);
        translate([cw/2-chw/2,-chd,thickness-chh-mpt]) cube([chw,cw+chd*2,chh]);
      }
    }
  }

  module keys() {
    for (k=key_pos) key(k[0],k[1],k[2],k[3],k[4]);
  }

  module key_raise(row,col,size,sink=0) {
    if (sink < 0)
    translate([kd*(col+(size-1)/2)+border,kd*row+border,0]) {
      translate([-(kd-cw)/2,-(kd-cw)/2,thickness+d]) cube([kd+d,kd+d,-sink*sink_unit+d*2]);
    }
  }

  module key_raises() {
    for (k=key_pos) key_raise(k[0],k[1],k[2],k[3]);
  }

  module key_expansion(row,col,size,sink,angle,height,extra,extra_right) {
    if (angle != 0)
    translate([kd*(col+(size-1)/2)+border,kd*row+border,0]) {
      rotate([0,0,angle]) {
        translate([-extra/4,-extra/4]) minkowski() {
          cube([cw+extra/2+extra_right,cw+extra/2,height]);
          cylinder(r=extra/4,h=d);
        }
      }
    }
  }

  module key_expansions(height,extra,extra_right=0) {
    for (k=key_pos) key_expansion(k[0],k[1],k[2],k[3],k[4],height,extra,extra_right);
  }

  module chip_house() {
    translate([0.5*kd-border,kd*2.2+(kd-cw)/2,-d*2]) cube([kd,kd*thw,thickness+d*4]);
  }

  module writing_left(row,col,height) {
    content = "收";
    font = "WenQuanYi Micro Hei";
    translate([col*kd+16,row*kd,height+thickness-d]) rotate([0,180,0])
      linear_extrude(height+2*d) {
        text(content, font = font, size = 10);
      }
  }

  module writing_right(row,col,height) {
    content = "获";
    font = "WenQuanYi Micro Hei";
    translate([col*kd,row*kd,thickness-d])
      linear_extrude(height+2*d) {
        text(content, font = font, size = 10);
      }
  }

  module front() {
    module screw_holes() {
      for (s=screws)
        translate([s[0]+x_shift, s[1]+y_shift,-d])
          cylinder(r=screw_radius, h=thickness+d*3);
    }

    difference() {
      union() {
        translate([corner-border+x_shift,corner-border+y_shift,0]) minkowski() {
          cube([length+border*2-corner*2,width+border*2-corner*2,thickness]);
          cylinder(r=corner,h=d);
        }
        key_expansions(thickness,cw*0.8);
      }
      keys();
      screw_holes();
      chip_house();
    }
    difference() {
      key_raises();
      keys();
    }
    //if (left) writing_left(4.2,0,2);
    //else writing_right(4.2,0,2);
  }

  module back() {
    thickness = 1.5;
    front_sink = 3;
    hole_depth = border*4+2*d;

    module cable_hole(w,h) {
      translate([10+x_shift,width-3+y_shift,border+ch-h-0.5])
        cube([w,border+6,h+2*d]);
    }

    module usb_hole(w,h) {
      translate([1.25*kd+2,width+corner+border-d,ch+border-h])
        cube([w,border+2*d,h+2*d]);
    }

    module screw_holes() {
      for (s=screws) {
        translate([s[0]+x_shift, s[1]+y_shift,-d])
          union() {
            cylinder(r=screw_radius, h=ch+thickness+d*2);
            cylinder(r=nut_radius, h=1+d*2);
          }
      }
    }

    module plate() {
      difference() {
        union() {
          difference() {
            union() {
              translate([corner-border+x_shift,corner-border+y_shift,0]) minkowski() {
                cube([length+border*2-corner*2,width+border*2-corner*2,ch+thickness]);
                cylinder(r=corner,h=d);
              }
              key_expansions(ch+thickness,cw*0.8);
            }
            union() {
              translate([corner+x_shift,corner+y_shift,thickness]) minkowski() {
                cube([length-corner*2,width-corner*2,ch+thickness]);
                cylinder(r=corner,h=d);
              }
              translate([0,0,thickness]) key_expansions(ch+thickness,cw*0.8-border*2,.1);
            }
          }
          // base for screw hole
          for (s=screws)
            translate([s[0]+x_shift, s[1]+y_shift,0])
              cylinder(r=4, h=ch+thickness);
        }
        screw_holes();
        if (left) cable_hole(4.5,4.5);
        else cable_hole(7.5,4.5);
      }
    }

    plate();
  }

  // For rack-bridge: thickness=3; first_shelf=70; second_shelf=20;
  module rack() {
    thickness=2.5;
    extra=1;
    rack_width=width+border*2+thickness*2+extra;
    first_shelf=47;
    second_shelf=16;
    rack_height=first_shelf+second_shelf+thickness*3;
    hook=5;

    module rack2d() {
      difference() {
        square([rack_height, rack_width]);
        translate([thickness,-d])
          square([first_shelf,rack_width+d*2]);
        translate([thickness*2+first_shelf,thickness])
          square([second_shelf,rack_width-thickness*2]);
        translate([rack_height-thickness-d,thickness+hook])
          square([thickness+d*2,rack_width-thickness*2-hook*2]);
        translate([-d,-d]) square([thickness+d*2,hook+d*2]);
        translate([-d,rack_width-hook-d]) square([thickness+d*2,hook+d*2]);
      }

      module arc() {
        difference() {
          circle(d=first_shelf + thickness*2);
          circle(d=first_shelf);
          translate([-first_shelf/2-thickness,0])
            square([first_shelf+thickness*2, first_shelf/2+thickness]);
        }
      }

      module curvy() {
        translate([first_shelf/2+thickness,rack_width-hook*2]) arc();
        translate([first_shelf/2+thickness,rack_width/2]) rotate([180,0,0]) arc();
        translate([first_shelf/2+thickness,hook*2]) rotate([0,0,180]) arc();
        translate([first_shelf/2+thickness,rack_width/2]) arc();
      }

      module straight() {
        angle=8;
        shift=(first_shelf+thickness)*tan(angle)+0.1;
        translate([0.5,shift]) rotate([0,0,-angle])
          square([first_shelf + thickness*2, thickness]);
        translate([0,rack_width/2-thickness/2])
          square([first_shelf + thickness*2, thickness]);
        translate([0.5,rack_width-thickness-shift]) rotate([0,0,angle])
          square([first_shelf + thickness*2, thickness]);
      }

      //translate([first_shelf/2+thickness/2,first_shelf/2+hook])
      //  square([thickness,rack_width-first_shelf-hook*2]);

      curvy();
      straight();
    }
    linear_extrude(height=5) rack2d();
  }

  //front();
  //translate([0,0,-ch-20]) back();
  translate([0,13,-ch-40]) rack();
}

module chip_cover() {
  wall=0.5;
  depth=1.0;
  extra=0.2;
  translate([-2.5,kd*2.2+2.5,0]) {
    cube([kd+wall,kd*thw+wall,wall]);
    translate([wall/2,wall/2+extra,-depth]) difference() {
      cube([kd,kd*thw-extra*2,depth]);
      translate([wall,wall,-d]) cube([kd-wall*2,kd*thw-extra*2-depth,depth+d*2]);
    }
  }
}

translate([-4*kd,-3*kd,0]) {
  case(left=false);
  // For rack-bridge: translate([3,0,0]) mirror([1,0,0]) case(left=true);
  //translate([-kd,0,0]) mirror([1,0,0]) case(left=true);
  //translate([-2,0,0]) rotate([0,180,0]) teensy(0,3.5,0);
  //rotate([0,180,0]) chip_cover();
}
