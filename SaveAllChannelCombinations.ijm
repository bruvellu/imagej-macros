// Save all possible channel combinations to PNGs

// Export all possible channel combinations to PNGs in the same directory as
// the original stack. Only works with single slices for now. Filenames should
// not have spaces.

// TODO: Make it work with Z-stacks
// TODO: Deal with spaces in file name

// Get stack path, name, and basename
path = getDirectory("image");
stackname = getTitle();
basename = File.getNameWithoutExtension(stackname);
rename(basename);

// Get stack dimensions
Stack.getDimensions(width, height, channels, slices, frames);

// Save PNG with all channels
run("RGB Color");
allchannels = basename + "_C1234"
saveAs("png", path + allchannels + ".png");
close();

// Split channels
selectWindow(basename);
run("Split Channels");

// Create and save every channel combination
for (i=1; i<=channels; i++) {
	for (j=i+1; j<=channels; j++) {
		// Merge two channels keeping original files
		run("Merge Channels...", "c1=C"+i+"-"+basename+" c2=C"+j+"-"+basename+" create keep");
		// Define name for combined stack
		combined = basename+"_C"+toString(i)+toString(j);
		rename(combined);
		// Convert to RGB for general use
		run("RGB Color");
		// Save as PNG
		saveAs("png", path + combined + ".png");
		// Close combined TIF
		close(combined);
	}
}

// Save single channels using the gray LUT
for (i=1; i<=channels; i++) {
	grayed = basename+"_C"+i;
	selectWindow("C"+i+"-"+basename);
	run("Grays");
	run("RGB Color");
	saveAs("png", path + grayed + ".png");
	close(grayed);
}

// Make stack and montage for inspection
open(path + allchannels + ".png");
run("Images to Stack", "use");
run("Make Montage...", "columns="+channels+" rows="+channels-1+" scale=1");
