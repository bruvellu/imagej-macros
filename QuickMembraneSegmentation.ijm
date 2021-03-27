// Quick membrane segmentation using MorphoLibJ

// Simple workflow to segment, label and display measurements (e.g. cell area)
// in a single image. It does not work properly for image stacks.

// Gets image name
title = getTitle();
basename = File.getNameWithoutExtension(title);

// Begin MorphoLibJ default segmentation
// Note: Waits are needed for the macro to work!
run("Morphological Segmentation");
wait( 1000 );

// Run membrane segmentation using default parameters
selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=10.0", "calculateDams=true", "connectivity=4");
wait( 1000 );

// Select catchment basins image type
selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Catchment basins");
wait( 1000 );

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

