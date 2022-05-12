# Loading the libraries

library(RangeShiftR)
library(raster)
library(RColorBrewer)
library(rasterVis)
library(latticeExtra)
library(viridis)
library(grid)
library(gridExtra)

dirpath = "Tutorial_01/" # Setting the path to 

dir.create(paste0(dirpath,'Inputs'), showWarnings = TRUE)
dir.create(paste0(dirpath,"Outputs"), showWarnings = TRUE)
dir.create(paste0(dirpath,"Output_Maps"), showWarnings = TRUE)

# For the tutorials see https://rangeshifter.github.io/RangeshiftR-tutorials/index.html
# Here is the path to data https://rangeshifter.github.io/RangeshiftR-tutorials/files/Tutorial1_Inputs.zip
# The data is to be downloaded and stored in Inputs folder

UKmap <- raster(paste0(dirpath, "Inputs/UKmap_1km.txt"))
SpDist <- raster(paste0(dirpath, "Inputs/Species_Distribution_10km.txt"))
values(SpDist)[values(SpDist) < 1] <- NA

# Plot land cover map and highlight cells with initial species distribution - option 1:

plot(UKmap, col = brewer.pal(n = 6, name = "Spectral"), axes = F)
plot(rasterToPolygons(SpDist, dissolve = F), add = T)

# Plot land cover map and highlight cells with initial species distribution - option 2 with categorical legend:

UKmap.f <- as.factor(UKmap)

# Add the land cover classes to the raster attributes table (RAT)

rat <- levels(UKmap.f)[[1]]

rat[["landcover"]] <- c("woodland", "arable", "improved grassland", "semi-natural grassland", "heath and bog", "other")

levels(UKmap.f) <- rat

custom.pal <- c("#1A9850", "#91CF60", "#D9EF8B", "#FEE08B", "#D8B365", "#777777")

levelplot(UKmap.f, margin = F, scales = list(draw = FALSE), col.regions = custom.pal) +
  layer(sp.polygons(rasterToPolygons(SpDist, dissolve = F), fill = NA, col = 'red'))
