# Loading the libraries for the task of mapping range shifts.

library(RangeShiftR)    # version 1.0.3
library(raster)         # version 3.5.15
library(RColorBrewer)   # version 1.1.3
library(rasterVis)      # version 0.51.2
library(latticeExtra)   # version 0.6.29
library(viridis)        # version 0.6.2
library(grid)           # version 4.2.0
library(gridExtra)      # version 2.3

dirpath = "Tutorial_01/" 

dir.create(paste0(dirpath,'Inputs'), showWarnings = TRUE) # Creating inputs folder
dir.create(paste0(dirpath,"Outputs"), showWarnings = TRUE) # Creating outputs folder
dir.create(paste0(dirpath,"Output_Maps"), showWarnings = TRUE) # Creating folder for created maps

# For the tutorials see https://rangeshifter.github.io/RangeshiftR-tutorials/index.html
# Here is the path to original data https://rangeshifter.github.io/RangeshiftR-tutorials/files/Tutorial1_Inputs.zip
# The data is to be downloaded and stored in the Inputs folder.

UKmap <- raster(paste0(dirpath, "Inputs/UKmap_1km.txt")) # Loading data 
SpDist <- raster(paste0(dirpath, "Inputs/Species_Distribution_10km.txt")) # Loading data
values(SpDist)[values(SpDist) < 1] <- NA

# Plot the land cover map and highlight all cells with initial species distribution - option 1:

plot(UKmap, col = brewer.pal(n = 6, name = "Spectral"), axes = F)

plot(rasterToPolygons(SpDist, dissolve = F), add = T)

# Plot the land cover map and highlight cells with initial species distribution - option 2 with categorical legend:

UKmap.f <- as.factor(UKmap)

# Add the land cover classes to the raster attributes table (rat)

rat <- levels(UKmap.f)[[1]]

rat[["landcover"]] <- c("woodland", "arable", "improved grassland", "semi-natural grassland", "heath and bog", "other")

levels(UKmap.f) <- rat

custom.pal <- c("#1A9850", "#91CF60", "#D9EF8B", "#FEE08B", "#D8B365", "#777777")

levelplot(UKmap.f, margin = F, scales = list(draw = FALSE), col.regions = custom.pal) +
  layer(sp.polygons(rasterToPolygons(SpDist, dissolve = F), fill = NA, col = 'red'))