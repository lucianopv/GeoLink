% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rastertile_processor.R
\name{filter_tiles}
\alias{filter_tiles}
\title{This function will crop and then mask rasters to the extent of the shapefile}
\usage{
filter_tiles(raster_objs, dt = shp_dt, numCores = NULL)
}
\arguments{
\item{raster_objs}{a list of rasters (typically the tiles that were read in)}

\item{dt}{the shapefile \code{sf} object}

\item{numCores}{the number of cores to be used, set to NULL if only 1 raster}
}
\description{
This function will crop and then mask rasters to the extent of the shapefile
}
