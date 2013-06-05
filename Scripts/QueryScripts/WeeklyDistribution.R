source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
queryCounter <- rep(0,7)
dataFrame <- data.frame(x= numeric(0), y= integer(0))

nQueries <- 0

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  sDate <- aQuery[[1]][1]
  oDate <- ymd_hms(sDate);
  
  #add to the vectors
  iIndex <- wday(oDate)
  queryCounter[iIndex] <<- queryCounter[iIndex] + 1
  nQueries <- nQueries + 1
}



#draw graphics
drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=c(1,2,3,4,5,6,7), y=dataFrame[[2]], group=1))
  plot <- plot + geom_line(stat="identity") + geom_point()
  plot <- plot + scale_x_continuous(breaks=c(1,2,3,4,5,6,7), labels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
  plot <- plot + scale_y_continuous(breaks=c(0.00,0.025,0.05,0.075,0.10,0.125,0.15,0.175,0.20), labels=c("0%", "2,5%","5%","7,5%","10%","12,5%","15%","17,5%","20%"))
  plot <- plot + xlab("Week days") + ylab("Number of queries per day")
  ggsave(paste(graphicsPath,"WeeklyDistribution.pdf", sep = "/"))
}

printToFile <- function(filename){
  write("QUERIES PER WEEK DAY", file=filename, append=FALSE)
  write(paste("Mean",mean(queryCounter),sep=" -> "), file=filename, append=TRUE)
  for(i in 1:7){
    write(paste(days[i],paste(queryCounter[i],percent(queryCounter[i]/nQueries),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  }
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(days, queryCounter/nQueries)
  filename <- paste(outputPath,"WeeklyDistribution.txt", sep = "/")
  print(dataFrame)
  printToFile(filename)
 # drawGraphics()
}

main()
