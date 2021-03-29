// Mirror individual stacks in a directory

// First run MirrorFlyEmbryosTest.ijm to determine the rfactor value (=number
// of slices to remove to achieve perfect roundness. Then run this macro to
// batch mirror individual timepoints from a directory into a specified
// directory. The macro expects image stacks of Drosophila embryos in lateral
// view and imaged more or less until the animal midline (anterior to the
// left). Mirroring is needed to generate cartographic projections in
// downstream processing.

// Directories
indir = getDirectory("Choose INPUT Directory");
outdir = getDirectory("Choose OUTPUT Directory");

// Get files
stacks = getFileList(indir);
timepoints = lengthOf(stacks);
//timepoints = 1;

// Slices to be removed for perfect roundness
rfactor = 5;

// Batch mode on
setBatchMode(true);

for (i=0; i<timepoints; i++) {
	// Spit name
	print(indir+stacks[i]);

	// Open file
	open(indir+stacks[i]);

	// Get original name
	name = getTitle();

	// Re-orient
	run("Rotate 90 Degrees Right");
	//run("Flip Horizontally", "stack");

	// Rename forward
	rename("forward");

	// Get image dimensions
	Stack.getDimensions(width, height, channels, slices, frames);

	// Remove slices if needed
	if (rfactor > 0) {
		run("Slice Remover", "first=1 last="+ rfactor +" increment=1");
	}
	
	// Rename reverse
	run("Duplicate...", "title=reverse duplicate");

	// 2-channel
	//run("Split Channels");
	//selectWindow("C1-reverse");
	//run("Reverse");
	//selectWindow("C2-reverse");
	//run("Reverse");
	//run("Merge Channels...", "c1=C1-reverse c2=C2-reverse create");

	// 1-channel
	run("Reverse");

	// Concatenate
	run("Concatenate...", "  title=mirror_"+ name +" image1=reverse image2=forward image3=[-- None --]");
	final = getTitle();
	run("Save", "save=" + outdir + final);
	close();

}

// Exit batch mode
setBatchMode(false);
