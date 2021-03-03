// Sync and combine stacks

// Get list of open stacks
list = getList("image.titles");

// Combine choices: vertically or horizontally?
combine = newArray("vertically", "horizontally");

// Create dialog to select stacks and corresponding frames
Dialog.create("Sync & Combine");
Dialog.addChoice("Top:", list);
Dialog.addNumber("Frame:", 20);
Dialog.addChoice("Bottom:", list);
Dialog.addNumber("Frame:", 20);
Dialog.addChoice("Combine:", combine);
Dialog.show();

// Get user-selected variables from dialog
top_title = Dialog.getChoice();
top_frame = Dialog.getNumber();
bottom_title = Dialog.getChoice();
bottom_frame = Dialog.getNumber();
orientation = Dialog.getChoice();

// Get the number of slices of each stack
selectWindow(top_title);
top_slices = nSlices();
selectWindow(bottom_title);
bottom_slices = nSlices();

// Print out reference information
print("Sync & Combine started...");
print("Top: "+ top_title);
print("  Slices: "+ top_slices);
print("  Frame: "+ top_frame);
print("Bottom: "+ bottom_title);
print("  Slices: "+ bottom_slices);
print("  Frame: "+ bottom_frame);
print("Combine: "+ orientation);

// Compute first and last frames for each stack
if (top_frame > bottom_frame) {
	diff = top_frame - bottom_frame;
	top_first = diff + 1;
	top_last = top_slices - diff;
	bottom_first = 1;
	bottom_last = top_last - diff;
} else if (top_frame < bottom_frame) {
	diff = bottom_frame - top_frame;
	bottom_first = diff + 1;
	bottom_last = bottom_slices - diff;
	top_first = 1;
	top_last = bottom_last - diff;
} else {
	print("PROBLEM! Top: "+ top_frame +" = Bottom: " +bottom_frame);
}

// Print out computations
print("Diff: "+ diff +" Top: "+ top_first +"-"+ top_last +" Bottom: "+ bottom_first +"-"+ bottom_last);

// Duplicate stacks and convert to RGB before combining
selectWindow(top_title);
run("Duplicate...", "title=top duplicate range=top_first-top_last");
run("RGB Color");
selectWindow(bottom_title);
run("Duplicate...", "title=bottom duplicate range=bottom_first-bottom_last");
run("RGB Color");

// Combine synced stacks
if (orientation == "vertically") {
	run("Combine...", "stack1=top stack2=bottom combine");	
} else {
	run("Combine...", "stack1=top stack2=bottom");
}
