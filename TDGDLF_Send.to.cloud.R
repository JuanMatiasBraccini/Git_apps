library(rsconnect)
if(!exists('handl_OneDrive')) source('C:/Users/myb/OneDrive - Department of Primary Industries and Regional Development/Matias/Analyses/SOURCE_SCRIPTS/Git_other/handl_OneDrive.R')

#---Share apps
#replace own computer with server that shares with the cloud
#note: put all stuff in the same directory (data, images, etc)!!!
#      save shiny code as app.R
Sys.setlocale(locale="English")
rsconnect::setAccountInfo(name='matias',
                          token='119661803DA371BDDD2B491978EFD87D',
                          secret='fMFWdXt2BaX90mwDvLi96WipkD4K9NAuZDr+4M+q')
Path=handl_OneDrive('Analyses/Apps/TDGDLF')
rsconnect::deployApp(Path)  
