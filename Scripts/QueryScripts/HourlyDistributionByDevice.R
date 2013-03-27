source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
#TODO
hours <- vector()
devices <- vector()
dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  sDate <- aQuery[[1]][1]
  sDevice <- aQuery[[1]][2]
  
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iHour <- hour(oDate)
  
  hours <<- append(hours, iHour)
  devices <<- append(devices, sDevice)
}


#draw graphics
drawGraphics <- function(){
  
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(hours, devices)
  print(dataFrame)
  drawGraphics()
}

main()