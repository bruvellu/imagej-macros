// Test mirroring image stack to achieve perfect roundness

// Mirrors and re-slice image stack for inspection. It expects a single
// timepoint of a Drosophila embryo imaged in lateral view (anterior to the
// left). Mirroring is needed to generate cartographic projections in
// downstream processing. Perfect roundness matter, therefore an rfactor
// parameter removes slices to adjust the final stack.

// Add or remove inner slices for perfect roundness
// Change as needed (positive adds, negative removes)
sfactor = 0;

// Duplicate first
run("Duplicate...", "duplicate");

// Re-orient
run("Rotate 90 Degrees Right");

// Rename forward
rename("forward");

// Get image dimensions
Stack.getDimensions(width, height, channels, slices, frames);
name = getTitle();

// Add or remove slices, if needed
if (sfactor < 0) {
	// Removes n deepest slices
	run("Slice Remover", "first=1 last="+ -sfactor +" increment=1");
} else if (sfactor > 0) {
	// Adds n copies of the deepest slice
	for (n=1; n<sfactor+1; n++) {
		setSlice(1);
		run("Copy");
		run("Add Slice");
		run("Paste");
		}
}
	
// Rename reverse
run("Duplicate...", "title=reverse duplicate");

// 1-channel
run("Reverse");

// Concatenate
run("Concatenate...", "  title=mirror_"+ name +" image1=reverse image2=forward image3=[-- None --]");

// Make line for re-slicing
makeLine(0, height*0.5, width, height*0.5);
run("Dynamic Reslice", " ");

// Make circle to check roundness
makeOval(width*0.1, width*0.1, width*0.7, width*0.7);

