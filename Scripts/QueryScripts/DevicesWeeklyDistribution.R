source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
dataFrame <- data.frame(x= numeric(0), y= integer(0))

tabletQueryCounter <- rep(0,7)
smartphoneQueryCounter <- rep(0,7)
cellphoneQueryCounter <- rep(0,7)

deviceType <- vector()

nTabletQueries <- 0
nSmartphoneQueries <- 0
nCellphoneQueries <- 0

parseString <- function(str){
  aQuery <- strsplit(str, separator)
  sDate <- aQuery[[1]][1]
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iIndex <- wday(oDate)
  if(aQuery[[1]][2] == "Tablet"){
    tabletQueryCounter[iIndex] <<- tabletQueryCounter[iIndex] + 1
    nTabletQueries <<- nTabletQueries + 1
  } else if(aQuery[[1]][2] == "Smartphone"){
    smartphoneQueryCounter[iIndex] <<- smartphoneQueryCounter[iIndex] + 1
    nSmartphoneQueries <<- nSmartphoneQueries + 1
  } else if(aQuery[[1]][2] == "Other Mobile Devices") {
    cellphoneQueryCounter[iIndex] <<- cellphoneQueryCounter[iIndex] + 1
    nCellphoneQueries <<- nCellphoneQueries + 1
  }
}



#draw graphics
drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]],colour=dataFrame[[3]]))
  plot <- plot + geom_line(stat="identity") + geom_point()
  plot <- plot + scale_x_continuous(breaks=c(1,2,3,4,5,6,7), labels=days)
  plot <- plot + scale_y_continuous(breaks=c(0.00,0.025,0.05,0.075,0.10,0.125,0.15,0.175,0.20), labels=c("0%", "2,5%","5%","7,5%","10%","12,5%","15%","17,5%","20%"))
  plot <- plot + xlab("Week days") + ylab("% of total queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"MobilePCWeeklyDistribution.jpg", sep = "/"))
}


mergeInfo <- function(){
   queryCounter <- c(tabletQueryCounter/nTabletQueries, smartphoneQueryCounter/nSmartphoneQueries, cellphoneQueryCounter/nCellphoneQueries)
 # queryCounter <- c(0.1655310,0.1447266,0.1360307,0.1329797,0.1288975, 0.1400704, 0.1517642,
   #                 0.1082380, 0.1670937, 0.1686073, 0.1627555, 0.1488917, 0.1402737, 0.1041401)
  print(queryCounter)
  deviceType <<- c(rep("Tablet",7), rep("Smartphone", 7), rep("Traditional", 7))
  print(deviceType)
  dataFrame <<- data.frame(c(1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7), queryCounter, deviceType)
}

main <- function(){
   readFromStdin()
  #create data frame
  mergeInfo()
  print(dataFrame)
  # filename <- paste(outputPath,"HourlyDistribution.txt", sep = "/")
  # printToFile(filename)
  drawGraphics()
}

main()