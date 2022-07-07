# :microscope: ImageJ Macros

My collection of macros for image processing in
[Fiji](https://fiji.sc/)/[ImageJ](https://imagej.github.io/).

## Processing

- [ResaveStacks.ijm](ResaveStacks.ijm): Re-save (overwrite) stacks in
  a directory; useful for fixing calibration or contrast in batch.
- [SplitTimepoints.ijm](SplitTimepoints.ijm): Save individual timepoints of
  a large timelapse dataset to directory.
- [SyncAndCombineStacks.ijm](SyncAndCombineStacks.ijm): Synchronize and combine
  two image stacks; useful for pairing timelapse movies.
- [MirrorFlyEmbryosTest.ijm](MirrorFlyEmbryosTest.ijm): Test parameters to
  achieve perfect roundness when mirroring a fly embryo stack.
- [MirrorFlyEmbryosBatch.ijm](MirrorFlyEmbryosBatch.ijm): Mirror fly embryo
  stacks in batch.

## Analyses

- [QuickMembraneSegmentation.ijm](QuickMembraneSegmentation.ijm): Segment and
  label cells in a single image using
  [MorphoLibJ](https://github.com/ijpb/MorphoLibJ).
- [MembraneSegmentation.ijm](MembraneSegmentation.ijm): Segment cells in stack
  and generate watershed for downstream analyses.
- [MembraneAnalyze.ijm](MembraneAnalyze.ijm): Analyze cell morphometry in stack
  outputting label maps for downstream visualization.
- [MembraneVisualize.ijm](MembraneVisualize.ijm): Visualize cell morphometry
  variables in stack by color-coding measurements.
- [IterativePIV.ijm](IterativePIV.ijm): Analyze particle image velocimetry in
  image stacks.

## Utilities

- [EnhanceContrastForAllChannels.ijm](EnhanceContrastForAllChannels.ijm):
  Quickly enhance the contrast of every channel in a stack. 

