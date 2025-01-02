# clumptest: A wrapper function to assess spatial autocorrelation in data (using R)

This function requires two pieces of information: an sf object, and the name of the column within the object that contains the data which may be spatially autocorrelated. Download the function and access it by sourcing it into your environment.

```
source(./[YOUR FILE PATH]/FUNCTION_clumptest.R) #load in custom functions

clumptest(data = [YOUR SHAPEFILE],
          col = "[COLUMN NAME IN QUOTES]")
```

Say for instance, we have a shapefile called `dc.grid`, which contains a column titled `dc.grid$prcnt.park`. Upon running the script, we would expect the following output:

```
clumptest(data = dc.grid,
          col = "prcnt.park")

> Moran's I: 0.5407978
> Significance (p): 2.721975e-214
>
> Recall that -1 indicates perfect dispersion, 0 indicates no autocorrelation, and 1 indicates perfect clustering.
```

Additionally, if `plot = TRUE`, the following local indicators of spatial analysis (LISA) is shown in the plotting window. Note that the function's default setting is `plot = TRUE`. Within the map, "HH" indicates a high concentration of the variable surrounded by other high regions of high concentration. "HL" indicates a high concentration of the variables surrounded by regions of low concentration. "LH" indicates a low concntration of the variable boarding regions of high concentration. "LL" indidcates low concentration of the variable in a region of similarly low concentration. LISA maps allow for a visual assessment of variable distributions to identify hotspots and coldspots.

![sample_lisa_map](https://github.com/user-attachments/assets/8f82df19-2b06-43e8-a1ea-ec16955f0415)


Finally, if `polyOut = TRUE`, the polygon used to build the above-shown map will be saved to your enviornment. Note that the function's default setting is `polyOut = FALSE`.

Please feel free to reach out if you have any questions or comments (herrerawildlife@gmail.com). However, note that this is purley a wrapper function. I canont address loss of functionality in the underlying functions.
