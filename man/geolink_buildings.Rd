% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geolink_mach.R
\name{geolink_buildings}
\alias{geolink_buildings}
\title{Download high resolution building data from WorldPop}
\usage{
geolink_buildings(
  version,
  iso_code,
  shp_dt = NULL,
  shp_fn = NULL,
  grid_size = NULL,
  survey_dt = NULL,
  survey_fn = NULL,
  survey_lat = NULL,
  survey_lon = NULL,
  buffer_size = NULL,
  extract_fun = "mean",
  survey_crs = 4326,
  indicators = "ALL",
  return_raster = FALSE,
  weight_raster = NULL
)
}
\arguments{
\item{version}{A character, the version of the building data to download. Options are "v1.1" and "v2.0".}

\item{iso_code}{A character, the ISO country code for the country of interest.}

\item{shp_dt}{An object of class 'sf', 'data.frame' which contains polygons or multipolygons representing the study area.}

\item{shp_fn}{A character, file path for the shapefile (.shp) to be read (for STATA users only).}

\item{grid_size}{A numeric, the grid size to be used in meters for analyzing the building data.}

\item{survey_dt}{An object of class "sf", "data.frame", a geocoded household survey with latitude and longitude values (optional).}

\item{survey_fn}{A character, file path for geocoded survey (.dta format) (for STATA users only & if use_survey is TRUE) (optional).}

\item{survey_lat}{A character, latitude variable from survey (for STATA users only & if use_survey is TRUE) (optional).}

\item{survey_lon}{A character, longitude variable from survey (for STATA users only & if use survey is TRUE) (optional).}

\item{buffer_size}{A numeric, the buffer size to be used around each point in the survey data, in meters (optional).}

\item{extract_fun}{A character, a function to be applied in extraction of raster into the shapefile.
Default is "mean". Other options are "sum", "min", "max", "sd", "skew" and "rms" (optional).}

\item{survey_crs}{An integer, the Coordinate Reference System (CRS) for the survey data. Default is 4326 (WGS84) (optional).}

\item{indicators}{character, default = "ALL", the set of indicators of interest}

\item{return_raster}{logical, default is FALSE, if TRUE a raster will be returned ONLY. The resulting
raster is cropped to the extent of \code{shp_dt} if \code{shp_dt} is specified. Otherwise, full raster from
source is downloaded.}

\item{weight_raster}{a raster object of class \code{spatRaster} or a list of \code{spatRaster} objects}
}
\value{
A processed data frame or object based on the input parameters and downloaded data.
}
\description{
Download high resolution building data from WorldPop
}
\details{
This function downloads high-resolution building data from WorldPop based
on the specified version and ISO country code. It can incorporate survey data
for further analysis. The building data is downloaded as raster files and can
be processed and analyzed using the \code{postdownload_processor} function.The data is extracted into
a shapefile provided by user. An added service for tesselating/gridding
the shapefile is also provided for users that need this data further analytics that require
equal area zonal statistics. Shapefile estimates at the grid or native polygon level is a
permitted final output. However, a geocoded survey with population estimates are the end goal
if the user also chooses. The function will merge shapefile polygons (either gridded or
native polygons) with the location of the survey units i.e. population estimates for the
locations of the units within the survey will be returned. The function is also set up for
stata users and allows the user to pass file paths for the household survey \code{survey_fn}
(with the lat and long variable names \code{survey_lon} and \code{survey_lat}) as well. This is requires
a .dta file which is read in with \code{haven::read_dta()} package. Likewise, the user is permitted
to pass a filepath for the location of the shapefile \code{shp_fn} which is read in with the
\code{sf::read_sf()} function.
}
\examples{

\dontrun{
\donttest{

#example usage with version 1.1
test_dt <- geolink_buildings(version = "v1.1",
                            iso_code = "NGA",
                            shp_dt = shp_dt[shp_dt$ADM1_PCODE == "NG001",],
                            indicators = "ALL",
                            grid_size = 1000)

}}
}
