# globals
utils::globalVariables(c(
  "sub_dir",
  "full_link",
  "exist_status",
  "shp_dt"
))

#' Download monthly rainfall chirp data
#'
#' Pull rainfall data from the CHIRPS data at monthly intervals for a specified period
#' The data is downloaded in raster format (.tif)
#'
#' @param start_date An object of class date, must be specified like as.Date("yyyy-mm-dd")
#' @param end_date An object of class date, must be specified like as.Date("yyyy-mm-dd")
#' @param link_base the link to the daily chirps data (no need to change this)
#'
#' @import data.table parallel raster
#' @export
#'


get_month_chirps <- function(start_date,
                             end_date,
                             link_base = "https://data.chc.ucsb.edu/products/CHIRPS/v3.0/") {
  dt <- chirpname_monthly(
    start_date = start_date,
    end_date = end_date
  )

  dt[, sub_dir := "monthly/global/tifs/"]

  dt[, full_link := paste0(
    link_base,
    sub_dir,
    filename
  )]

  dt$exist_status <- unlist(lapply(X = dt$full_link,
                                   FUN = checkurl_exist))


  raster_objs <- lapply(X = dt[exist_status == TRUE, full_link],
                        FUN = download_reader,
                        shp_dt = shp_dt)

  return(raster_objs)
}

#' Download annual rainfall chirp data
#'
#' Pull rainfall data from the CHIRPS data at monthly intervals for a specified period
#' The data is downloaded in raster format (.tif)
#'
#' @param start_year An integer for the first year CHIRPS data to download
#' @param end_year An integer for the final year in the series of annual rasters to download
#' @param link_base the link to the daily chirps data (no need to change this)
#' @param cores the number of PC cores to employ in pulling the data in parallel
#'
#' @import data.table parallel raster
#' @export
#'


get_annual_chirps <- function(start_year,
                              end_year,
                              link_base = "https://data.chc.ucsb.edu/products/CHIRPS/v3.0/",
                              cores = 1L) {
  dt <- chirpname_annual(
    start_year = start_year,
    end_year = end_year
  )

  dt <- data.table(filename = dt)

  dt[, sub_dir := "annual/global/tifs/"]

  dt[, full_link := paste0(
    link_base,
    sub_dir,
    filename
  )]

  dt$exist_status <- unlist(lapply(X = dt$full_link,
                                   FUN = checkurl_exist))


  raster_objs <- lapply(X = dt[exist_status == TRUE, full_link],
                        FUN = download_reader,
                        shp_dt = shp_dt)

  return(raster_objs)


}
