// Quick membrane segmentation using MorphoLibJ

// Simple workflow to segment, label and display measurements (e.g. cell area)
// in a single image. It does not work properly for image stacks.

// Gets image name
title = getTitle();
basename = File.getNameWithoutExtension(title);

// Waiting time needed for MorphoLibJ macro to work
waitime = 5000;

// Begin MorphoLibJ default segmentation
// Note: Waits are needed for the macro to work!
run("Morphological Segmentation");
wait(waitime);

// Run membrane segmentation using default parameters
selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=10.0", "calculateDams=true", "connectivity=4");
wait(waitime);

// Select catchment basins image type
selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Catchment basins");
wait(waitime);

// Generate segmentation results
selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

// Remove labels from borders
run("Remove Border Labels", "left right top bottom");

// Calculate area and other measurements of segmented cells
run("Analyze Regions", "area perimeter circularity euler_number bounding_box centroid equivalent_ellipse ellipse_elong. convexity max._feret oriented_box oriented_box_elong. geodesic tortuosity max._inscribed_disc average_thickness geodesic_elong.");
finalname = basename + "-catchment-basins-killBorders";

// Open menu to select the measurement to be displayed (needs manual input)
selectWindow(finalname);
run("Assign Measure to Label");

// To call programmatically get name of results file and define parameter to plot
//run("Assign Measure to Label", "results="+ finalname +" column=Circularity min=0.679 max=0.931");

