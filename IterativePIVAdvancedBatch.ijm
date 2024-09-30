// Iterative PIV (Advanced) analysis for stacks

// Uses the iterativePIV ImageJ plugin: https://sites.google.com/site/qingzongtseng/piv
// Essentially a copy of their multislicePIV macro: https://raw.githubusercontent.com/qztseng/imagej_plugins/master/macro_scripts/multislice%20PIV.txt
// Check tutorial to adjust parameters properly: https://sites.google.com/site/qingzongtseng/piv/tuto

// Get stack ID and number of slices
imgID = getImageID();
slices = nSlices;

// Select values for iterative PIV
Dialog.create("Multi-slice PIV");
Dialog.addNumber("Interrogation window 1", 200);
Dialog.addNumber("search window 1", 400);
Dialog.addNumber("vector spacing 1", 100);
Dialog.addNumber("Interrogation window 2", 100);
Dialog.addNumber("search window 2", 200);
Dialog.addNumber("vector spacing 2", 50);
Dialog.addNumber("Interrogation window 3", 50);
Dialog.addNumber("search window 3", 100);
Dialog.addNumber("vector spacing 3", 25);
Dialog.addNumber("correlation threshold", 0.9);
Dialog.show();

// Get values
piv1 = Dialog.getNumber();
sw1 = Dialog.getNumber();
vs1 = Dialog.getNumber();
piv2 = Dialog.getNumber();
sw2 = Dialog.getNumber();
vs2 = Dialog.getNumber();
piv3 = Dialog.getNumber();
sw3 = Dialog.getNumber();
vs3 = Dialog.getNumber();
corr = Dialog.getNumber();

// Define output folder
path = getDirectory("Select folder to save PIV results");

// Call iterative PIV (Advanced) for each slice
setBatchMode(true);
for (slice = 1; slice < slices; slice++) {
	
	// Select stack for analysis
    selectImage(imgID);
    
    // Define zero-padding depending on number of slices
    pad = floor(log(slices) / log(10)) + 1;
    spad = IJ.pad(slice, pad);
    
    // Duplicate stack with a pair of slices to be analyzed
    run("Duplicate...", "title=[seq_" + spad + "] duplicate range=" + slice + "-" + (slice + 1));
    
    // Run iterative PIV (Advanced) on this two-slice stack
    run("iterative PIV(Advanced)...", "  piv1=" + piv1 + " sw1=" + sw1 + " vs1=" + vs1 + 
        " piv2=" + piv2 + " sw2=" + sw2 + " vs2=" + vs2 + 
        " piv3=" + piv3 + " sw3=" + sw3 + " vs3=" + vs3 + 
        " correlation=" + corr + " path=[" + path + "] batch");
        
    // Close all images, except main stack
    nImgs = nImages;
    for (n = 1; n < nImgs; n++) {
        selectImage(1);
        if (getImageID() != imgID) close();
    }
}
setBatchMode(false);
