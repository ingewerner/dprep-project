# Deletes files in all subdirectories with the endings specified here
fileEndings <- c('*.log','*.aux','*.Rout','*.Rhistory')
for (fi in fileEndings) { 
  files <- list.files(getwd(),fi,include.dirs=F,recursive=T,full.names=T,all.files=T)
  file.remove(files)
}

# Delete all files in temp directories
# (does note delete hidden files starting with . (e.g. .gitkeep is not deleted))
unlink(paste(getwd(),'/gen/data-preparation/temp/*',sep=''),recursive=T,force=T)
unlink(paste(getwd(),'/gen/data-preparation*',sep=''),recursive=T,force=T)
unlink(paste(getwd(),'/datasets*',sep=''),recursive=T,force=T)

# Delete temporary (hidden) R files
file.remove('.RData')
file.remove('.Rhistory')
file.remove('../gen/data-preparation/temp/BLM2020_dataset')
file.remove('../gen/data-preparation/temp/BLM2021_dataset')


