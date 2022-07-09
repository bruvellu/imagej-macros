// Crop single slice from a hyperstack

// This macro crops a single slice from an image stack, saving the cropping
// coordinates and dimensions in the output filename. This is useful if you
// need the exact crop position to recover scaling/measurements from the
// original stack. There's also an option to flip horizontally or vertically.

// 1. Open the hyperstack as a virtual stack
// 2. Go to the slice you want to extract
// 3. Make a rectangular selection to be cropped
// 4. Run the macro

// Get stack title without extension
filename = getTitle();
title = File.getNameWithoutExtension(filename);

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

// Get min/max display values
getMinAndMax(min, max);

// Alternative way to manually input the cropping values
// Choose a single slice
//slice = 20;
// Set X origin for cropping, usually 0 (top left)
//origx = 0;
// Set Y origin for cropping, usually 0 (top left) for top half
//origy = 50;
// Set rectangle width for cropping, usually stack's full width
//cropw = width;
// Set rectangle height for cropping, manually defined
//croph = 890;

// Get slice number from current slice
Stack.getPosition(channel, slice, frame);

// Get values from selection
getSelectionBounds(origx, origy, cropw, croph);

// Set transformation needed to orient embryo with anterior to the left
flip = "n"; // n=no flipping, h=horizontal, v=vertical, hv=horiz/vert, vh=vert/horiz

// Define output filename with information
cropped = title +"_s"+ slice +"_"+ origx +"x"+ origy +"_w"+ cropw +"_h"+ croph +"_flip"+ flip +".tif";

// Create ROI
makeRectangle(origx, origy, cropw, croph);

// Duplicate cropped slice
run("Duplicate...", "title="+ cropped +" duplicate slices="+ slice);

// Flip if necessary
if ( flip == "h" ) {
	run("Flip Horizontally", "stack");
} else if ( flip == "v" ) {
	run("Flip Vertically", "stack");
} else if ( flip == "hv" ) {
	run("Flip Horizontally", "stack");
	run("Flip Vertically", "stack");
} else if ( flip == "vh" ) {	
	run("Flip Vertically", "stack");
	run("Flip Horizontally", "stack");
}

// Set previous min/max display values to output
setMinAndMax(min, max);

// Save
saveAs("Tiff");

// Close
close("*");
