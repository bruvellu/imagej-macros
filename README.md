# :microscope: ImageJ Macros

My collection of macros for image processing in
[Fiji](https://fiji.sc/)/[ImageJ](https://imagej.github.io/).

## Processing

- [ResaveStacks.ijm](ResaveStacks.ijm): Re-save (overwrite) stacks in a directory for fixing the calibration or contrast in batch.
- [SplitTimepoints.ijm](SplitTimepoints.ijm): Save individual timepoints of a large timelapse dataset to directory.
- [SyncAndCombineStacks.ijm](SyncAndCombineStacks.ijm): Synchronize and combine two image stacks for pairing timelapse movies.
- [CropSliceFromStack.ijm](CropSliceFromStack.ijm): Extract and crop a single slice from a stack saving the coordinates.
- [MirrorFlyEmbryosTest.ijm](MirrorFlyEmbryosTest.ijm): Test parameters for perfect roundness before mirroring fly embryo stacks.
- [MirrorFlyEmbryosBatch.ijm](MirrorFlyEmbryosBatch.ijm): Mirror stacks of fly embryos in batch.

## Analyses

- [QuickMembraneSegmentation.ijm](QuickMembraneSegmentation.ijm): Segment and label cells in a single image using
  [MorphoLibJ](https://github.com/ijpb/MorphoLibJ).
- [MembraneSegmentation.ijm](MembraneSegmentation.ijm): Segment cells in stack and generate watershed for downstream analyses.
- [MembraneAnalyze.ijm](MembraneAnalyze.ijm): Analyze cell morphometry in stack outputting label maps for downstream visualization.
- [MembraneVisualize.ijm](MembraneVisualize.ijm): Visualize cell morphometry variables in stack by color-coding measurements.
- [IterativePIVAdvancedBatch.ijm](IterativePIVAdvancedBatch.ijm): Analyze particle image velocimetry in image stacks.

## Utilities

- [EnhanceContrastForAllChannels.ijm](EnhanceContrastForAllChannels.ijm): Quickly enhance the contrast of every channel in a stack. 
- [SaveAllChannelCombinations.ijm](SaveAllChannelCombinations.ijm): Export all possible channel combinations to PNGs. 
