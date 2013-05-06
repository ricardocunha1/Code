source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

hours <- 0:23
dataFrame <- data.frame(x= numeric(0), y= integer(0))

mobileQueryCounter <- rep(0,24)
pcQueryCounter <- rep(0,24)

deviceType <- vector()

nMobileQueries <- 0
nPCQueries <- 0
state <- 0

parseString <- function(str){
  aQuery <- strsplit(str, separator)
  hour <- as.integer(aQuery[[1]][1])
  
  #add to the vectors
  iIndex <- hour + 1
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
  plot <- plot + scale_x_continuous(breaks=c(0,4,8,12,16,20,23))
  plot <- plot + scale_y_continuous(breaks=c(0.00,0.025,0.05,0.075,0.10,0.125,0.15,0.175,0.20), labels=c("0%", "2,5%","5%","7,5%","10%","12,5%","15%","17,5%","20%"))
  plot <- plot + xlab("Hours of the day") + ylab("% of total queries")
  plot <- plot + labs(colour="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"MobilePCHourlyDistribution.jpg", sep = "/"))
}

mergeInfo <- function(){
  hours <<- c(hours, hours)
  #print(hours)
  queryCounter <- c(mobileQueryCounter/nMobileQueries, pcQueryCounter/nPCQueries)
 #queryCounter <- c(0.02,0.023,0.045,0.054,0.02,0.023,0.045,0.054,0.02,0.023,0.045,0.054,
#                    0.02,0.023,0.045,0.054,0.02,0.023,0.045,0.054,0.02,0.023,0.045,0.254,
 #                   0.01,0.042,0.055,0.087,0.01,0.042,0.055,0.087,0.01,0.042,0.055,0.087,
  #                  0.01,0.042,0.055,0.087,0.01,0.042,0.055,0.087,0.01,0.042,0.055,0.087)
  deviceType <<- c(rep("Mobile",24), rep("Desktop", 24))
  dataFrame <<- data.frame(hours, queryCounter, deviceType)
}

main <- function(){
  readFromStdin()
  #create data frame
  mergeInfo()
 # filename <- paste(outputPath,"HourlyDistribution.txt", sep = "/")
 # printToFile(filename)
  drawGraphics()
  print(dataFrame)
}

main()