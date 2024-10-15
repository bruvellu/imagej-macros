// Plot vectors for IterativePIV analysis

// 1. IterativePIVAdvancedBatch.ijm
// 2. IterativePIVPlot.ijm
// 3. IterativePIVOverlay.ijm

// Define parameters for plotting
Dialog.create("plot PIV stack");
Dialog.addString("piv iteration:", "PIV3");
Dialog.addNumber("vector scale", 2.5);
Dialog.addNumber("max vector value", 8);
Dialog.addNumber("plot width", 800);
Dialog.addNumber("plot height", 800);
Dialog.show();

// Save parameters
iter = Dialog.getString();
scale = Dialog.getNumber();
max = Dialog.getNumber();
width = Dialog.getNumber();
height = Dialog.getNumber();

// Get directory with files
dir = getDirectory("directory of the PIV data");
filelist = getFileList(dir);

setBatchMode(true);

for(i = 0; i < filelist.length; i++){
	
	// Get PIV file and path
	pivfile = filelist[i];
	pivpath = dir + File.separator + pivfile;
	
	// Filter selected iteration
	if(endsWith(pivfile, iter + "_disp.txt")){
		
		// Plot PIV vectors
		run("plot...", "select=["+ pivpath +"] vector_scale="+ scale +" max="+ max +" plot_width="+ width +" plot_height="+ height +" lut=S_Pet");
		
		// Get plot name without spaces
		plotname = getTitle();
		plotname = replace(plotname, " ", "_");
		rename(plotname);
		
		// Skip concatenating first plot
		if (startsWith(plotname, "Vector_plot_seq_001")) {
			rename("piv");
		} else {
			run("Concatenate...", "stack1=piv stack2=" + plotname + " title=piv");
		}
	}
}

setBatchMode("exit and display");

// exit
// run("plot...", "select=/home/nelas/Dropbox/Projects/Cephalic_furrow/7-Paper/1-analyses/tissue-flows/1-piv/crop/seq_20_PIV3_disp.txt vector_scale=1 max=10 plot_width=700 plot_height=700 show draw lut=S_Pet");
