source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
queryCounter <- rep(0,7)
dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  sDate <- aQuery[[1]][1]
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iIndex <- wday(oDate)
  queryCounter[iIndex] <<- queryCounter[iIndex] + 1
}



#draw graphics
drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=c(1,2,3,4,5,6,7), y=dataFrame[[2]], group=1))
  plot <- plot + geom_line() + geom_point()
  plot <- plot + scale_x_continuous(breaks=c(1,2,3,4,5,6,7), labels=days)
  plot <- plot + geom_hline(yintercept=mean(dataFrame[[2]]), colour="blue")
  plot <- plot + xlab("Week days") + ylab("Number of queries per day")
  ggsave(paste(graphicsPath,"WeeklyDistribution.txt", sep = "/"))
}

printToFile <- function(filename){
  write("QUERIES PER WEEK DAY", filename, append=FALSE)
  write(paste("Mean",mean(queryCounter),sep" -> "), filename, append=TRUE)
  for(i in 1:7){
    write(paste(days[i],queryCounter[i],sep=" -> "), filename, append=TRUE)
  }
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(days, queryCounter)
  filename <- paste(outputPath,"WeeklyDistribution.txt", sep = "/")
  printToFile(filename)
  drawGraphics()
}

main()
