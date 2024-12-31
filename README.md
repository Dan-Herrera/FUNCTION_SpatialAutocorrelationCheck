# clumptest: A wrapper function to assess spatial autocorrelation in data (using R)

This function requires two pieces of information: a sf object, and the name of the column within the object that contains the data which may be spatially autocorrelated. Download the function and access it by sourcing it into your environment.

```
source(./[YOUR FILE PATH]/FUNCTION_clumptest.R) #load in custom functions

clumptest(data = [YOUR SHAPEFILE],
          col = "[COLUMN NAME IN QUOTES]")
```

Say for instance, we have a shapefile called..., which contains a column titled... Upon running the script we would expect the following output:

```
clumptest(data = [YOUR SHAPEFILE],
          col = "[COLUMN NAME IN QUOTES]")

> MESSAGE
```

Additionally, if `plot = TRUE`, the following plot is shown in the plotting window. Note that the function's default setting is `plot = TRUE`.

INSERT A MAP

Finally, if `polyOut = TRUE`, the polygon used to build the above-shown map will be saved to your enviornment. Note that the function's default setting is `polyOut = FALSE`.

Please feel free to reach out if you have any questions or comments (herrerawildlife@gmail.com). However, note that this is purley a wrapper function. I canont address loss of functionality in the underlying functions.
