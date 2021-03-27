// Membrane segmentation using MorphoLibJ

// Performs membrane segmentation on image stack (frame by frame), and exports
// the watershed lines as a new image stack.

// Get stack name
title = getTitle();
basename = File.getNameWithoutExtension(title);
watername = basename + "-watershed";

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

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
	// Note: Waits are needed for the macro to work!
	run("Morphological Segmentation");
	wait( 1000 );
	
	// Run membrane segmentation using default parameters
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=20.0", "calculateDams=true", "connectivity=4");
	wait( 1000 );
	
	// Select catchment basins image type
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Watershed lines");
	wait( 1000 );

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
	
}

// Now edit watershed lines manually for downstream analyses
