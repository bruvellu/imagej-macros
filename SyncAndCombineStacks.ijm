// Synchronize and combine image stacks for pairing two timelapse movies

// Get the list of opened stacks
stackList = getList("image.titles");

// Combine choices: vertically or horizontally?
combineChoices = newArray("vertically", "horizontally");

// Create dialog to select stacks to combine
Dialog.create("Select the stacks to combine");
Dialog.addChoice("Stack A:", stackList);
Dialog.addChoice("Stack B:", stackList);
Dialog.addChoice("Combine:", combineChoices);
Dialog.show();
// Get user-selected variables from dialog
stackA = Dialog.getChoice();
stackB = Dialog.getChoice();
orientation = Dialog.getChoice();

// Get information from each stack
selectWindow(stackA);
Stack.getDimensions(widthA, heightA, channelsA, slicesA, framesA);
Stack.getPosition(channelA, sliceA, frameA);
selectWindow(stackB);
Stack.getDimensions(widthB, heightB, channelsB, slicesB, framesB);
Stack.getPosition(channelB, sliceB, frameB);

// TODO: Swap slices and frames, if needed, or abort

// Create dialog to select stacks to combine and corresponding frames
Dialog.create("Set the corresponding frames between stacks");
Dialog.addNumber(stackA, frameA);
Dialog.addNumber(stackB, frameB);
Dialog.show();
// Get user-selected variables from dialog
keyframeA = Dialog.getNumber();
keyframeB = Dialog.getNumber();

// Print out reference information
print("Sync & Combine started...");
print("Stack A: " + stackA);
print("Keyframe A: " + keyframeA);
print("Stack B: " + stackB);
print("Keyframe B: " + keyframeB);
print("Combine: " + orientation);

// Get diff between keyframes
diff = keyframeA - keyframeB;

// Set first and last frames for each stack
if (diff > 0) {
	// Trim beginning of stackA
	stackA_first = 1 + diff;
	stackA_last = framesA;
	// Trim ending of stackB
	stackB_first = 1;
	stackB_last = framesB - diff;
	
} else if (diff < 0) {
	// Get absolute value
	diff = abs(diff);
	// Trim ending of stackA
	stackA_first = 1;
	stackA_last = framesA - diff;
	// Trim beginning of stackB
	stackB_first = 1 + diff;
	stackB_last = framesB;
	
} else if (diff == 0) {
	// Don't trim any frames
	stackA_first = 1;
	stackA_last = framesA;
	stackB_first = 1;
	stackB_last = framesB;

}

// Print out computations
print("Diff: " + diff);
print("Stack A: " + stackA_first + "-" + stackA_last);
print("Stack B: " + stackB_first + "-" + stackB_last);

// Duplicate stacks and convert to RGB before combining
selectWindow(stackA);
run("Duplicate...", "title=top duplicate range=stackA_first-stackA_last");
run("RGB Color");
selectWindow(stackB);
run("Duplicate...", "title=bottom duplicate range=stackB_first-stackB_last");
run("RGB Color");

// Combine synced stacks
if (orientation == "vertically") {
	run("Combine...", "stack1=top stack2=bottom combine");	
} else if (orientation == "horizontally") {
	run("Combine...", "stack1=top stack2=bottom");
}

// Rename combined stack
combined = "COMBINE_stackA_stackB";
rename(combined);
// Get dimensions of combined stack
selectWindow(combined);
Stack.getDimensions(widthC, heightC, channelsC, slicesC, framesC);

// Swap slices by frames for consistency
Stack.setDimensions(channelsC, framesC, slicesC);
Stack.getDimensions(widthC, heightC, channelsC, slicesC, framesC);
print("Stack C: " + framesC + " frames");
