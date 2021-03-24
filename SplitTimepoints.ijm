// Split timepoints of large datasets

// First, open dataset as virtual stack, then run the macro

// Get stack title and dimensions
data = getTitle();
Stack.getDimensions(w, h, channels, slices, frames);

// Define label to be appended to file name
label = "_CARE_TP";

// Select output directory
outdir = getDirectory("Choose OUTPUT Directory");

setBatchMode(true); // batch mode on

for (i=1; i<frames+1; i++) {
	selectWindow(data);
	Stack.setFrame(i);

	// Frame name
	frame = replace(data, ".tif", label + i + ".tif");

	// Duplicate frame
	run("Duplicate...", "title=" + frame + " duplicate channels=" + channels + " frames=" + i);

	// Use color
	run("Grays");
	
	//Save
	saveAs("Tiff", outdir + frame);
	close(frame);
}

setBatchMode(false); // exit batch mode
