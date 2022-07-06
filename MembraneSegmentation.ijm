// Membrane segmentation using MorphoLibJ

// Performs membrane segmentation on image stack (frame by frame), and exports
// the watershed lines as a new image stack.

// Get stack name and basename
title = getTitle();
basename = File.getNameWithoutExtension(title);

// Set name for output watershed stack
watername = basename + "-watershed";

// Define tolerance value for segmentation
tolerance = 20;

// Waiting time needed for MorphoLibJ macro to work
waitime = 5000;

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

// Hotfix: Swap slices by frames if needed
// TODO: Handle this better
if (frames == 1 && slices > 1) {
	run("Properties...", "slices=" + frames + " frames=" + slices);
	//Stack.setDimensions(channels, slices, frames);
}

// Create new stack for watershed
newImage(watername, "8-bit color-mode", width, height, channels, slices, frames);

// Loop over slices
for (i=1; i<=frames; i++) {

	// Select window
	selectWindow(title);
	
	// Set current frame
	Stack.setFrame(i);

	// Duplicate current slice
	run("Duplicate...", " ");

	// Begin MorphoLibJ default segmentation
	run("Morphological Segmentation");
	wait( waitime);
	
	// Run membrane segmentation using default parameters
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=" + tolerance, "calculateDams=true", "connectivity=4");
	wait( waitime );
	
	// Select catchment basins image type
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Watershed lines");
	wait( waitime );

	// Generate segmentation results
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

	// Generate segmentation results
	close("Morphological Segmentation");

	// Copy watershed line
	run("Copy");

	// Close watershed line
	close();	

	// Select watershed stack and set to current frame
	selectWindow(watername);
	Stack.setFrame(i);

	// Paste watershed
	run("Paste");
	
	// Deselect
	run("Select None");
	
}

// Watershed is ready for editing or for downstream analyses
