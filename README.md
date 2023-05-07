# Darknight: DIY 60% Split Keyboard
[Ergonomic Design](#ergonomic-design) -
[Layout](#layout) -
[Parts](#parts) -
[Tools](#tools) -
[Construction](#construction) -
[Updates](#updates)

## Ergonomic Design

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Darknight.jpg)
 * 60% keyboard for programmers, especially vim users
 * Symmetric ortholinear / matrix layout
 * Split and tentable
 * Tenting angle quickly adjustable by moving the tenting racks inwards or outwards
 * Mild contour to adapt to finger lengths, with z-staggering and cherry-profile keycaps

## Layout

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Darknight%20layout.png)
 * Fn key is at the home position of left thumb, which makes cursor moving keys on the right half easily accessible.
 * Ctrl and Fn keys are dual-role modifiers. When tapped, they produce Escape, Enter and Backspace instead. The only downside is that they can’t auto-repeat because they are modifiers when pressed and held. (Hint: Use Ctrl-Backspace to delete words.)
 * Left-click and right-click are at the bottom row of the left half. One can move the mouse with right hand and click on the keyboard with left hand.
 * Brackets and Backslash are at the bottom row of the right half. Single-quote is right above Enter. These changes allow the right half to have only 6 columns and mirror the left half.
 * The blue keys are the home keys of fingers at rest.

## Parts

 * 6 3D-printed case pieces and 2 tenting racks
   * Front piece, back piece and chip cover for each case
   * 8 M2x16 screws and 8 M2 nuts for assembling the cases
 * 60 Gateron red switches (or any Cherry MX compatible switches), plate mounted
 * 60 Blank PBT keycaps from a 120-piece set
   * 60 O-rings for dampening
 * One Teensy 3.2 or Teensy LC as controller
 * For handwired matrix
   * 22 AWG 6-color stranded hook-up wires
   * One 0.25mm copper sheet, 6x6 inches
   * 60 1N4148 diodes
 * One USB-C gen 2 cable (with plugs cut off) for connecting halves.
   See [issue #1](https://github.com/macroxue/keyboard-diy/issues/1).
 * One USB mini cable for connecting the keyboard to computer

## Tools

 * 3D printer
 * Soldering iron
 * Tweezers
 * Wire stripper
 * Heavy duty scissors
 * Knife
 * Nails and hammer
 * Filer
 * Multimeter

## Construction

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Inside%20cases.jpg)

### Printing cases and tenting racks: 17 hours
 * Print cases: 16 hours with PLA and 12 hours with ABS
 * Print tenting racks: 2 hours with PLA and 1.5 hours with ABS
 * Print chip covers: 10 minutes

3D models in STL format as well as the OpenSCAD file producing them are in [models](https://github.com/macroxue/keyboard-diy/tree/master/models) directory. I use FlashPrint for FlashForge Creator Pro to convert STL files to X3G files before printing them from a SD card.

There are three choices of racks. [rack-rigid.stl](https://github.com/macroxue/keyboard-diy/tree/master/models/rack-rigid.stl) is quick to print and rigid for high tenting angle. [rack-curvy.stl](https://github.com/macroxue/keyboard-diy/tree/master/models/rack-curvy.stl) is good looking but not rigid. [rack-blend.stl](https://github.com/macroxue/keyboard-diy/tree/master/models/rack-blend.stl) is good looking and rigid.

### Installing switches and keycaps: 20 minutes
 * Install switches: 10 minutes
 * Orient switches: pins are at the top half
 * Install O-rings and keycaps: 10 minutes <img src=https://github.com/macroxue/keyboard-diy/blob/master/images/O-ring.jpg width=200>

### Wiring diagrams
![](https://github.com/macroxue/keyboard-diy/blob/master/images/right-wiring.png)
![](https://github.com/macroxue/keyboard-diy/blob/master/images/left-wiring.png)
 * Use any of the digital pins except pin 13 (LED)
 * Feel free to use pins different than what are in the diagrams

### Wiring switch columns: 2 hours, 1 for each split
<img src=https://github.com/macroxue/keyboard-diy/blob/master/images/Soldering%20column.jpg width=600>

 * Mark on stranded wire where column pins are
 * Use wire stripper to cut at each mark and 5mm to the right of the mark, i.e. two horizontal cuts 5mm apart at each mark
 * Make a vertical cut between the two horizontal cuts with a knife and remove the insulation to expose the strands
 * Split strands into two parts so a column pin can get through
 * Solder the wire to the pins

### Wiring switch rows and diodes: 4 hours, 2 for each split
 * Cut 3~4mm wide stripe off copper sheet with heavy-duty scissors
 * Mark positions of row pins on the stripe
 * Drill small holes (D~=1mm) at the marks and an extra hole at the end toward the center for wiring the row to the controller
   * Use hammer and nail if no drill at hand
 * Diodes with black terminal oriented downward
   * The black terminal is inserted into a hole on the stripe and bent upward
   * The other terminal is wrapped around a row pin for at least one complete circle <img src=https://github.com/macroxue/keyboard-diy/blob/master/images/Soldering%20diode.jpg width=200>
 * Make sure the stripe doesn’t touch any exposed part of column wires
 * Solder diodes to row pins
 * Solder diodes to copper stripe. When solder is applied with the side (not the tip) of the iron touching the stripe, a small “flooding” area of solder creates a strong solder joint. <img src=https://github.com/macroxue/keyboard-diy/blob/master/images/Soldering%20row.jpg width=200>
 * Cut off extra length of diode terminals

### Testing and fixing: 20 minutes
 * Use a multimeter. Turn the dial to diode sign.
 * Red on column, black on row
 * Press the key at the column-row. Multimeter should read current.

### Connecting the right matrix to controller: 2 hours
![](https://github.com/macroxue/keyboard-diy/blob/master/images/Wiring%20controller.png)
 * Avoid *pin 13* which is for the built-in LED
 * Figure out how to route the wires before soldering
 * Rows are routed with fairly short wires so either solid or stranded wires work
 * Columns are routed with stranded wires for flexibility
 * The controller has its program/reset button facing down so it's accessible without opening the case

### Connecting the left matrix to USB-C: 1 hour
![](https://github.com/macroxue/keyboard-diy/blob/master/images/Left%20matrix.jpg)
 * Prepare USB-C cable
   * Cut the plugs off
   * Insert the cable into a few O-rings, which can act as stoppers
   * Mark the length to reach the furthest column
   * Make a round cut at the mark with a knife and remove the insulation
   * Remove the silver-colored mesh and paper wrap to expose wires
   * Observe 4 thin wires and 10 thick wires (2 from a twisted pair)
   * Solder 4 thin wires into one
 * Pin or tape USB-C cable so it doesn’t move around
 * Decide which wire for which column/row
 * Color coding helps, e.g. red USB-C wire to red column wire
 * Cut wires to proper lengths
 * Use soldering iron to remove insulation at the end of each wire
 * Wrap strands around a soldering joint and solder

### Connecting left and right rows: 30 minutes
 * Prepare USB-C cable to expose wires at the other end
 * Pin or tape USB-C cable so it doesn’t move around
 * Cut wires to proper lengths
 * Use soldering iron to remove insulation at the end of each wire
 * Wire rows of the left half to rows of the right half, so logically there are 5 rows.

### Connecting left columns to controller: 30 minutes
 * Ground the silver-colored mesh to GND pin of the controller. Ghost keys can pop up without this.
 * Wire columns of the left half to the controller

### Uploading firmware
 * Note down which controller pin each row/column is wired to. There are 5 rows and 12 columns. Column 0 is where left shift is and column 11 is where right shift is.
 * Plug in USB mini cable to the controller and connect the keyboard to a computer.
 * Download [Teensyduino](https://www.pjrc.com/teensy/teensyduino.html) which extends Arduino to support Teensy controllers.
 * Clone [firmware repo](https://github.com/macroxue/keyboard-firmware) on the computer.
 * Update [keyboards/darknight/darknight.ino](https://github.com/macroxue/keyboard-firmware/blob/master/keyboards/darknight/darknight.ino) with above-noted row pins and column pins.
 * Create a symbolic link in Arduino's libraries directory to the cloned firmware directory.
 * Open `darknight.ino` in Arduino IDE.
 * In the IDE, change "Tools > Board" setting to be "Teensy LC" or "Teensy 3.2/3.1" depending on the controller chip, and change "Tools > USB Type" setting to "Keyboard + Mouse + Joystick".
 * Use "Sketch > Verify/Compile" to make sure the firmware compiles fine, then use "Sketch > Upload" to upload the firmare to the controller.
 * Test the new keyboard!

It happened once that pressing any two keys among Q, W, E, R and T at the same time would also produce Tab. It was fixed by swapping the wires connecting to the first row and the second row. The exact cause is still unknown but a guess is along the line of induced current.

### Closing the cases: 10 minutes
 * Make sure USB mini cable and USB C cable fit in the cable hole
   * May need to enlarge the cable hole with a filer
 * Insert screws and fasten the cases with nuts

### Installing tenting racks: 5 minutes

 * Cut 8mm pieces from USB-C insulation and insert rack feet into the pieces to increase friction on surface <img src=https://github.com/macroxue/keyboard-diy/blob/master/images/Tenting%20rack.jpg width=400>
 * Slide each case into a rack and adjust tenting angle
![](https://github.com/macroxue/keyboard-diy/blob/master/images/Brightday.jpg)

## Updates
### New build on 7/7/2019
Change of color scheme. Maybe call it WhiteKnight.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Red-n-white.jpg)

### New build on 12/30/2020
What else is better than building another keyboard in these holidays! I call this one RedBaron.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Red%20Baron.jpg)

Now I have three such keyboards, Darknight trapped at work due to the pandemic, WhiteKnight for working at home and RedBaron for personal use.

For this build, I just used stranded wires for the matrix. It turns out to be simpler since the wires can be routed to the controller directly.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Stranded%20Matrix.jpg)

### High-angle tenting on 11/12/2021

A bridge connecting the two halves turns out to be a good solution for high-angle tenting. The bridge is simply the two tenting racks joined together, with small adjustments in size.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Bridge.jpg)

With a little more engineering, the entire structure can be locked by tension so it can be easily moved around.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Bridge%20tension.jpg)

### New build on 5/7/2023

Darknight is officially missing in the office during the COVID pandemic. Site maintenance
took it as a company equipment and recycled it. After nearly 4 years of heavy use, Gateron
Red linear switches in WhiteKnight begin to fail. Tangerine is the new replacement build.

![](https://github.com/macroxue/keyboard-diy/blob/master/images/Tangerine.jpg)

One surprise is with the USB-C cable ordered from Amazon, which is thicker and has many
more ground wires than before. I just leave them unused.
