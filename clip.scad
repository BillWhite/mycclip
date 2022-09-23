EPSILON=.05;
TOLERANCE=.5;

bagW=140;
slotO=5;
slotW=5;
slotD=6;
slotAssemblyW=2*slotO*slotW;

clipW=2*slotAssemblyW + bagW;
clipD=10;
clipH=10;

notchOpening=5;
notchOpeningH=clipH - 2*notchOpening;
notchSide=sqrt(notchOpening*notchOpening/2);

gapD=2;

lockW=slotW - TOLERANCE;
lockD=2*clipD+gapD;
lockH=2*clipH;
lockHoleD=2*(clipD-slotD)+gapD+EPSILON+TOLERANCE;

module slot(eps, tol) {
    translate([-slotW/2,
               -slotD/2,
               -eps])
        cube([slotW+tol, 
              slotD+tol, 
              clipH+2*eps]);
}

module unnotched() {
    difference() {
        translate([-clipW/2, 0, 0]) {
            cube([clipW, clipD, clipH]);
        }
        translate([-(clipW/2-slotW/2-slotO), slotD/2-EPSILON, 0]) {
            slot(eps=EPSILON, tol=TOLERANCE);
        }
        translate([(clipW/2-slotW/2-slotO), slotD/2-EPSILON, 0]) {
            slot(eps=EPSILON, tol=TOLERANCE);
        }
    }
}

module notch(eps=EPSILON) {
    translate([0, clipD, clipH/2]) {
        rotate([45, 0, 0]) {
            cube([clipW+eps, notchSide, notchSide], center=true);
        }
    }
}

module negative() {
    difference() {
        unnotched();
        notch();
    }
}

module positive() {
    union() {
        unnotched();
        notch(eps=0);
    }
}

module lock() {
    difference() {
        cube([lockW, lockD, lockH]);
        translate([-EPSILON, (lockD-lockHoleD)/2, -EPSILON]) {
            cube([lockW+2*EPSILON,
                  lockHoleD,
                  clipH+EPSILON]);
        }
    }
}

previewGapD=gapD/2;

npreviewX=0;
npreviewY=-clipD-previewGapD;
npreviewZ=0;

ppreviewX=0;
ppreviewY=clipD+previewGapD;
ppreviewZ=0;

lpreviewX=-clipW/2+slotO;
lpreviewY=-(clipD + gapD/2);
lpreviewZ=1.1*clipH+EPSILON;

if ($preview) {
    translate([npreviewX, npreviewY, npreviewZ]) {
        negative();
    }
    translate([ppreviewX, ppreviewY, ppreviewZ]) {
        translate([0, 0, clipH]) {
            rotate([180, 0, 0]) {
                positive();
            }
        }
    }
    translate([lpreviewX, lpreviewY, lpreviewZ]) {
        lock();
    }
}

//
// This program is free software: you can redistribute it and/or modify it 
// under the terms of the GNU General Public License as published by the 
// Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License 
// along with this program. If not, see <https://www.gnu.org/licenses/>.
//
