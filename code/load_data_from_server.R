################################################################################
# Load the Lynx Collar Data from the I&M Server and Save it Locally            #
#                                                                              #
# Author: McCrea Cobb <mccrea_cobb@fws.gov>                                    #
# Date created: 9/7/2018                                                       #
# Date edited: 3/8/2019                                                        #
#                                                                              #
# Changed the output to a RData file in an attempt to remove all data clean up #
# functions from the Shiny app.                                                #
################################################################################


#-------------------------------------------------------------------------------
## Update the flat.file on the server
## Requires PulseSecure
## Make sure that the server drive is mapped first! (->FWS Tools to Go->Map Drives)

## Process all QFP location data

setwd("s:/InvMon/biometrics/_projects/refuge/_regional_projects/lynx/code")

source("s:/InvMon/biometrics/_projects/refuge/_regional_projects/lynx/code/functions/batch.flat.gps.R")

batch.flat.gps(iridium_csv.dir = "s:/im_archive/boreal_lynx/products/iridium_csv",
               save.file = TRUE,
               save.dir = "s:/InvMon/biometrics/_projects/refuge/_regional_projects/lynx/data/derived_data/gps_collar/telonics",
               returnx = FALSE,
               pattern = "Complete")
setwd("C:/Users/mcobb/OneDrive - DOI/products/r_shiny_apps/collar-viewer")


## Fetch the flat file dataset and add in the capture data variables (age class, study site):
source("./code/functions/fetch_remote_data.R")
fetch_remote_data(flat.gps = "s:/InvMon/biometrics/_projects/refuge/_regional_projects/lynx/data/derived_data/gps_collar/telonics/flat.gps.gzip",
              dat.collar = "s:/InvMon/biometrics/_projects/refuge/_regional_projects/lynx/data/raw_data/capture/capture_data.RData",
              clean = TRUE,
              save = TRUE,
              savedir = paste0("C:/Users/mcobb/DOI/Northwest Boreal Lynx Project - data/derived/shiny_app/collar_data_", as.numeric(format(as.Date(Sys.Date()), '%Y%m%d')), ".RData"),
              returnit = FALSE)
