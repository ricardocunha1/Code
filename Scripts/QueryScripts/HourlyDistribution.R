source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

hours <- 0:23
queryCounter <- rep(0,24)
dataFrame <- data.frame(x= numeric(0), y= integer(0))

nQueries <- 0

parseString <- function(str){
  aQuery <- strsplit(str, separator)
  hour <- as.integer(aQuery[[1]][1])
  
  #add to the vectors
  iIndex <- hour + 1
  queryCounter[iIndex] <<- queryCounter[iIndex] + 1
  nQueries <<- nQueries + 1
}



#draw graphics
drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], group=1))
  plot <- plot + geom_line() + geom_point()
  plot <- plot + scale_x_continuous(breaks=c(0,4,8,12,16,20,23))
  plot <- plot + geom_hline(yintercept=mean(dataFrame[[2]]), colour="blue")
  plot <- plot + xlab("Hours of the day") + ylab("Number of queries per hour")
  ggsave(paste(graphicsPath,"HourlyDistribution.pdf", sep = "/"))
}

printToFile <- function(filename){
  write("QUERIES PER WEEK DAY", file=filename, append=FALSE)
  write(paste("Mean",mean(queryCounter),sep=" -> "), file=filename, append=TRUE)
  for(i in 1:24){
    write(paste(hours[i],paste(queryCounter[i],percent(queryCounter[i]/nQueries),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  }
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(hours, queryCounter/nQueries)
  print(dataFrame)
  filename <- paste(outputPath,"HourlyDistribution.txt", sep = "/")
  printToFile(filename)
  drawGraphics()
}

main()
