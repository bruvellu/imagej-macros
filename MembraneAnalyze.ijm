// Analyze membrane segmentation using MorphoLibJ

// Analyze the morphometry of segmented cells on image stack containing
// watershed lines, output stack with labeled cells and data tables.

// Get stack path and name
path = getDirectory("image");
stackname = getTitle();

// Set names for later usage
basename = File.getNameWithoutExtension(stackname);
mapname = replace(basename, "watershed", "labelmap.tif");
tablename = replace(basename, "watershed", "morphometry");

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

// Loop over slices
for (i=1; i<=frames; i++) {

	// Select window
	selectWindow(stackname);
	
	// Set current frame
	Stack.setFrame(i);

	// Duplicate current frame
	run("Duplicate...", " ");
	rename("frame");

	// Remove labels from borders
	run("Kill Borders");
	rename("killborders");

	// Identify connected components
	run("Connected Components Labeling", "connectivity=4 type=[16 bits]");
	rename("labelmap");

	// Calculate area and other measurements of segmented cells
	run("Analyze Regions", "area perimeter circularity centroid convexity max._feret geodesic tortuosity average_thickness");
	
	// Name automatically given to measurements window
	morphometry = tablename + "-frame" + i + ".txt";
	Table.rename("labelmap-Morphometry", morphometry);

	// Add shape index to table
	Table.applyMacro("Shape=Perimeter/Math.sqrt(Area) Frame=" + i, morphometry);
	
	// Save table to file
	Table.save(path + morphometry);
	
	// Copy label image and paste to label stack
	selectWindow("labelmap");
	run("Set Label Map", "colormap=[Golden angle] background=Black");
	rename("labelmap" + i);

	// Close temporary windows
	close(morphometry);
	close("killborders");
	close("frame");

}

// Close main stack
close(stackname);

// Concatenate images to labelmap stack
run("Images to Stack", "name=" + mapname + " use");

// Save labelmap to file
save(path + mapname);

// Close files
close(mapname);

// Labelmap and morphometry are ready for downstream analyses and visualization
