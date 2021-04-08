// Iterative PIV analysis for stacks

// Uses the iterativePIV ImageJ plugin: https://sites.google.com/site/qingzongtseng/piv
// Essentially a copy of their multislicePIV macro: http://goo.gl/Ug9gy
// Check tutorial to adjust parameters properly: https://sites.google.com/site/qingzongtseng/piv/tuto

// Get stack ID and number of slices
id0 = getImageID();
slices = nSlices;

// Select values for iterative PIV
Dialog.create("Multi-slice PIV");
Dialog.addNumber("Interrogation window 1", 450);
Dialog.addNumber("search window 1", 900);
Dialog.addNumber("vector spacing 1", 250);
Dialog.addNumber("Interrogation window 2", 300);
Dialog.addNumber("search window 2", 600);
Dialog.addNumber("vector spacing 2", 150);
Dialog.addNumber("Interrogation window 3", 150);
Dialog.addNumber("search window 3", 300);
Dialog.addNumber("vector spacing 3", 75);
Dialog.addNumber("correlation threshold", 0.9);
Dialog.show;

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
path = getDirectory("select a folder to save PIV results");

// Call iterative PIV for each slice
setBatchMode(true);
for(s=1;s<slices;s++){
	selectImage(id0);
	pad = floor(log(slices)/log(10))+1;
	spad = IJ.pad(s,pad);
	run("Duplicate...", "title=[seq_"+spad+"] duplicate range="+s+"-"+s+1+"");
	run("iterative PIV(Advanced)...", "  piv1="+piv1+" sw1="+sw1+" vs1="+vs1+" piv2="+piv2+" sw2="+sw2+" vs2="+vs2+" piv3="+piv3+" sw3="+sw3+" vs3="+vs3+" correlation="+corr+" batch path=["+path+"]");
	nI = nImages;
	//print(nI);
	for(n=1;n<nI;n++){
		selectImage(1);
		//print(n);
		//print(getTitle());
		if(getImageID!=id0)close();
	}
}
setBatchMode(false);
