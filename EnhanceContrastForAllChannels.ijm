// Automatically equalize levels for all channels

// When opening raw datasets the levels are often not optimal. This macro
// helps to quickly equalize the contrast of all channels.

// Manually set the Z slice position before running the macro.

// Get stack dimensions
stack = Stack.getDimensions(width, height, channels, slices, frames);

// Make composite
run("Make Composite");

// Loop over channels adjusting the levels
for (i = 1; i <= channels; i++) {
	// Set channel
    Stack.setChannel(i);
    // Reset levels first
    resetMinAndMax();
    // Enhance contrast minimally
    run("Enhance Contrast", "saturated=0.01");
}