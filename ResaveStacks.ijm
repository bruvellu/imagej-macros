// Re-save stacks in directory

// Useful to set the correct scaling in batch for image stacks in a directory.
// You can also adjust contrast, change LUT or perform other imaging processing
// steps such as cropping.
// 
// WARNING: this macro re-saves in place and will overwrite your stacks in the
// specified directory.

// Directory with stacks
indir = getDirectory("Choose INPUT Directory");

// Get files
stacks = getFileList(indir);
timepoints = lengthOf(stacks)

// Set Batch Mode
setBatchMode(true);

// Open, merge and save
for (i=0; i<timepoints; i++) {

	// Spit name
	print(indir+stacks[i]);

	// Open file
	open(indir+stacks[i]);

	// Get image dimensions
	Stack.getDimensions(w, h, channels, slices, frames);
	name = getTitle();

	// Fix voxel depth or pixel width
	//run("Properties...", "channels="+ channels +" slices="+ slices +" frames="+ frames +" unit=micron pixel_width=0.2749087 pixel_height=0.2749087 voxel_depth=1.0000 frame=[1.47 sec]");
	run("Properties...", "channels="+ channels +" slices="+ slices +" frames="+ frames +" unit=pixel pixel_width=1.0 pixel_height=1.0 voxel_depth=4.0");
	
	// Adjustments
	run("Grays");
	setMinAndMax(250, 2500);
	//makeRectangle(1, 1, 1896, 1046);
	//run("Crop");
	//run("Slice Remover", "first=106 last="+ slices +" increment=1");
	//run("Slice Remover", "first=1 last=13 increment=1");
	//run("Flip Horizontally", "stack");
	//run("Flip Vertically", "stack");
		
	// Save patched
	run("Save");

	// Close output
	close(name);

}

// Set Batch Mode
setBatchMode(false);
