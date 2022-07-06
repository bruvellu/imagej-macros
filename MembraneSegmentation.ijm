// Membrane segmentation using MorphoLibJ

// Performs membrane segmentation on image stack (frame by frame), and exports
// the watershed lines as a new image stack.

// Get stack path, name and basename
path = getDirectory("image");
stackname = getTitle();
basename = File.getNameWithoutExtension(stackname);

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
	frames = slices;
	slices = 1;
}

// Create new stack for watershed
//newImage(watername, "32-bit color-mode", width, height, channels, slices, frames);

// Loop over slices
for (i=1; i<=frames; i++) {

	// Select window
	selectWindow(stackname);
	
	// Set current frame
	Stack.setFrame(i);

	// Duplicate current slice
	run("Duplicate...", " ");

	// Begin MorphoLibJ default segmentation
	run("Morphological Segmentation");
	wait(waitime);
	
	// Run membrane segmentation using default parameters
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=" + tolerance, "calculateDams=true", "connectivity=4");
	wait(waitime);
	
	// Select catchment basins image type
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Watershed lines");
	wait(waitime);

	// Generate segmentation results
	selectWindow("Morphological Segmentation");
	call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");
	rename("watershed" + i);

	// Generate segmentation results
	close("Morphological Segmentation");
	// Close mysterious hidden stack
	close(basename + "-1.tif");
}

// Close main stack
close(stackname);

// Concatenate images to watershed stack
run("Images to Stack", "name=" + watername + " use");

// Set dimensions
Stack.setDimensions(channels, slices, frames);

// Save watershed to file
save(path + watername);

// Close watershed
close(watername);

// Watershed is ready for editing or for downstream analyses
