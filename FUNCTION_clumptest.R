### moran's I and LISA function

clumptest <- function(data, col, plot=TRUE, polyOut=FALSE){ #begin function
  
  #install required packages if needed
  all.packages <-  as.vector(installed.packages())
  if(!("remotes" %in% all.packages)){install.packages("remotes")}
  if(!("sfweight" %in% all.packages)){remotes::install_github("Josiahparry/sfweight")}
  if(!("spdep" %in% all.packages)){install.packages("spdep")}
  if(!("ggplot2" %in% all.packages)){install.packages("ggplot2")}
  if(!("sf" %in% all.packages)){install.packages("sf")}
  #need an error for if plot is true and mapview isn't
  
  #load packages
  library(sfweight) #allows calculation of LISA
  library(spdep) #allows calculation of morans I
  library(ggplot2) #allows complex plotting
  library(sf) #allows working with spatial data
  
  #check for errors 
  if(!(sum(class(data) %in% c("sf","data.frame"))==2)){stop("'data' must be an sf object.")}
  if(!(class(col) %in% "character")){stop("'col' must be a character string that corresponds with the column name of the variable you with to inspect.")}
  if(!(col %in% names(data))){stop(paste(col," is not a valid column name inside sf dataframe.", sep=""))}
  if(sum(is.na(st_drop_geometry(data[,col]))) > 0 ){message("Cannot calculate Moran's I when NA's are present in the dataset. Removing polygons with NA's now.")}
  
  data <- data[!is.na(data[,col][[1]]),] #removes NA's from dataset
  set.ZeroPolicyOption(TRUE) #tells R it is okay to have cells without neighbors
  
  #isolate to column of interest
  data <- data[,c(col, attr(data, "sf_column"))]
  
  #set up for morans I
  nb <- poly2nb(data, queen=TRUE) #creates a list of neighrbos (queen's case) around each grid cell
  lw <- nb2listw(nb, style="W", zero.policy=TRUE) #creates a list of weights for each neighbor
  
  #I <- moran(grid$lg_prst, lw, length(nb), Szero(lw))[1]
  
  moran.data <- st_drop_geometry(data[,1])
  moran.data <- as.vector(moran.data[,1])
  morantest <- moran.test(moran.data, listw=lw, alternative="greater")
  moranI <- as.numeric(morantest$estimate[1]) #isolate moran's I
  moranP <- as.numeric(morantest$p.value[1]) #isolate p value
  
  message(cat("Moran's I: ",moranI, "\n",
              "Significance (p): ", moranP, "\n",
              "\n",
              "Recall that -1 indicates perfect dispersion, 0 indicates no autocorrelation, and 1 indicates perfect clustering.", sep=""))
  
  if(plot==TRUE){#start plotting instructions
    
    # calucualte the lisa groups
    wts <- st_weights(nb,style="W", allow_zero = TRUE) #creates a list of weights for each neighbor (originally contained zero.policy = TRUE instead of allow_zero but that threw errors)
    lag.data <- st_drop_geometry(data) #remove geometry from data
    lag.data <- as.numeric(as.vector(lag.data[,1])) #convert data into a numeric vector
    data.no.geom <- st_drop_geometry(data) #remove geometry from data
    data.no.geom <- as.vector(data.no.geom[,1]) #convert data into a vector
    lag <- st_lag(lag.data,nb,wts) #calculate lag
    LISA <- categorize_lisa(data.no.geom, lag) #categorize
    data$LISA <- LISA #add LISA data to the dataframe
    
    # report results
    LISA.map <- ggplot(data = data) +
      geom_sf(aes(fill = LISA),
              color = "transparent")+
      scale_fill_manual(values = c("#fa0202","#fad2d2","#b1c0fc","#0233f7"),
                        breaks = c("HH","HL","LH","LL"))+
    theme_void()+ggtitle(col)
    
    print(LISA.map) #display map in plots window
    LISA.map #leave this here for R to pick up
    
  }#end plotting instructions
  
  if(polyOut==TRUE){
    poly.LISA <<- data
    message("polygon saved to environment as 'poly.LISA'")}
} #end of function
