// Analyze membrane segmentation using MorphoLibJ

// Analyze the morphometry of segmented cells on image stack containing
// watershed lines, and generate a color-coded stack for a specified parameter
// (e.g. area). Also outputs stack with labeled cells.

// Get stack name
title = getTitle();
basename = File.getNameWithoutExtension(title);
areaname = basename + "-area";
mapname = basename + "-map";

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

// Create new stacks for area and label map
newImage(areaname, "8-bit color-mode", width, height, channels, slices, frames);
newImage(mapname, "8-bit color-mode", width, height, channels, slices, frames);
// Set label map for label map stack
run("Set Label Map", "colormap=[Golden angle] background=Black shuffle");

// Loop over slices
for (i=1; i<=frames; i++) {
	// Select window
	selectWindow(title);
	
	// Set current frame
	Stack.setFrame(i);

	// Duplicate current frame
	run("Duplicate...", " ");
	rename("frame");

	// Remove labels from borders
	//run("Remove Border Labels", "left right top bottom");
	run("Kill Borders");
	rename("killborders");

	// Identify connected components
	run("Connected Components Labeling", "connectivity=4 type=[16 bits]");
	rename("labelmap");

	// Calculate area and other measurements of segmented cells
	run("Analyze Regions", "area perimeter circularity centroid convexity max._feret geodesic tortuosity average_thickness");
//	run("Analyze Regions", "area perimeter circularity euler_number bounding_box centroid equivalent_ellipse ellipse_elong. convexity max._feret oriented_box oriented_box_elong. geodesic tortuosity max._inscribed_disc average_thickness geodesic_elong.");

	// Name of measurements window
	morphometry = "labelmap-Morphometry";

	// Assign area to label map
	run("Assign Measure to Label", "results="+ morphometry +" column=Area min=10 max=2000");
	rename("area");

	// Copy area image and paste to area stack
	run("Copy");
	// Select area stack and set to current frame
	selectWindow(areaname);
	Stack.setFrame(i);
	// Paste area
	run("Paste");
	// Clear selection
	run("Select None");

	// Copy label image and paste to label stack
	selectWindow("labelmap");
	run("Copy");
	// Select label stack and set to current frame
	selectWindow(mapname);
	Stack.setFrame(i);
	// Paste label
	run("Paste");
	// Clear selection
	run("Select None");

	// Close temporary windows
	close("labelmap-Morphometry");
	close("labelmap");
	close("area");
	close("killborders");
	close("frame");

}
