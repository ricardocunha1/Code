source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

nQueries <- 0
deviceType <- vector()
deviceTypeCounter <- vector()

state <- 0

parseString <- function(str){
  if(state == 0){
    nQueries <<- as.integer(str)
    state <<- state + 1
  } else {
    aLine <- strsplit(str, separator)
    deviceType <<- append(deviceType, aLine[[1]][1])
    deviceTypeCounter <<- append(deviceTypeCounter, as.integer(aLine[[1]][2]))
  }
}

printToFile <- function(filename){
  write("MOBILE DEVICE TYPES", file=filename, append=FALSE)
  for(i in 1:length(deviceType)){
    write(paste(deviceType[i],paste(deviceTypeCounter[i],percent(deviceTypeCounter[i]/nQueries),sep=" -> "),sep=" -> "),
          file=filename,
          append=TRUE)
  }
}

readFromStdin();
filename <- paste(outputPath,"ExtractMobileDeviceType.txt", sep = "/")
printToFile(filename)