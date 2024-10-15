// Overlay IterativePIV vectors on stack

// 1. IterativePIVAdvancedBatch.ijm
// 2. IterativePIVPlot.ijm
// 3. IterativePIVOverlay.ijm

// Get stack name and dimensions
stack = getTitle();
Stack.getDimensions(width, height, channels, slices, frames);

// Swap slices with frames, if needed
if (slices > frames) {
	Stack.setDimensions(channels, frames, slices);
	Stack.getDimensions(width, height, channels, slices, frames);
}

// Duplicate stack without first frame
run("Duplicate...", "title=stack duplicate range=2-" + frames);
Stack.getDimensions(width, height, channels, slices, frames);

// Loop over frames to overlay PIV
for (i=1; i<frames+1; i++){
	selectWindow("piv");
	setSlice(i);
	selectWindow("stack");
	setSlice(i);
	run("Add Image...", "image=piv x=0 y=0 opacity=100 zero");
}

// Set name for PIV overlay
pivovername = "PIV_Overlay_" + stack;
rename(pivovername);

// Flatten overlay
run("Flatten", "stack");

// Set name for PIV stack
selectWindow("piv");
pivname = "PIV_" + stack;
rename(pivname);
