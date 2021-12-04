# FastNormalEstimation
Fast Surface Normal Estimation for Organized Point Clouds (Depth maps)

MATLAB implementations of the following paper:
 Multiple Cylinder Extraction from Organized Point Clouds 

If you are using these codes in your researches, kindly cite the following paper:

[Moradi, Saed, Denis Laurendeau, and Clement Gosselin. "Multiple Cylinder Extraction from Organized Point Clouds." Sensors 21.22 (2021): 7630](https://www.mdpi.com/1424-8220/21/22/7630)

## MATLAB

You can find the single-scale (7by7) implementation of the ADMD algorithm in MATLAB subdirectory. The multi-scale version can be easily constructed by max selection among different scales (see the paper for further information). To achieve saliency-map, just pass the test image through **AdMD7_eff** function:

```matlab
test_img=double(test_img);
Filtered_image = AdMD7_eff(test_img);
```

