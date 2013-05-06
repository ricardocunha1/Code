source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
dataFrame <- data.frame(x= numeric(0), y= integer(0))

mobileQueryCounter <- rep(0,7)
pcQueryCounter <- rep(0,7)

deviceType <- vector()

nMobileQueries <- 0
nPCQueries <- 0

parseString <- function(str){
  aQuery <- strsplit(str, separator)
  sDate <- aQuery[[1]][1]
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iIndex <- wday(oDate)
  if(aQuery[[1]][2] == "Desktop"){
    pcQueryCounter[iIndex] <<- pcQueryCounter[iIndex] + 1
    nPCQueries <<- nPCQueries + 1
  } else {
    mobileQueryCounter[iIndex] <<- mobileQueryCounter[iIndex] + 1
    nMobileQueries <<- nMobileQueries + 1
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
 # queryCounter <- c(mobileQueryCounter/nMobileQueries, pcQueryCounter/nPCQueries)
  queryCounter <- c(0.1655310,0.1447266,0.1360307,0.1329797,0.1288975, 0.1400704, 0.1517642,
                    0.1082380, 0.1670937, 0.1686073, 0.1627555, 0.1488917, 0.1402737, 0.1041401)
  print(queryCounter)
  deviceType <<- c(rep("Mobile",7), rep("Desktop", 7))
  print(deviceType)
  dataFrame <<- data.frame(c(1,2,3,4,5,6,7,1,2,3,4,5,6,7), queryCounter, deviceType)
}

main <- function(){
 # readFromStdin()
  #create data frame
  mergeInfo()
  print(dataFrame)
  # filename <- paste(outputPath,"HourlyDistribution.txt", sep = "/")
  # printToFile(filename)
  drawGraphics()
}

main()