source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
queriesPerSession <- vector()
queriesPerSessionMean <- vector()
numberSessions <- 0

dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  aLine <- strsplit(str, ">>>")
  queriesPerSession <<- append(queriesPerSession, as.integer(aLine[[1]][2]))
  numberSessions <<- numberSessions + as.integer(aLine[[1]][2])
  
  #add to queriesPerSessionMean to calculate mean, median and std dev.
  i<-0
  while(i<as.integer(aLine[[1]][2])){
    queriesPerSessionMean <<- append(queriesPerSessionMean, as.integer(aLine[[1]][1])+1)
    i<-i+1
  }
}

printToFile <- function(filename){
  write("X QUERIES PER SESSION", file=filename, append=FALSE)
  for(i in 1:length(queriesPerSession)){
    write(paste(i,paste(queriesPerSession[i],percent(queriesPerSession[i]/numberSessions),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  }
  
  write(paste("Mean Queries per Session", mean(queriesPerSessionMean), sep=" ->"), file=filename, append=TRUE)
  write(paste("Median Queries per Session", median(queriesPerSessionMean), sep=" ->"), file=filename, append=TRUE)
  write(paste("Std Dev Queries per Session", sd(queriesPerSessionMean), sep=" ->"), file=filename, append=TRUE)
  
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]]))
  plot <- plot + geom_bar(stat="identity")
  plot <- plot + scale_x_continuous(breaks=1:10, labels=c("1","2","3","4","5","6","7","8","9","10+"))
  plot <- plot + scale_y_continuous(breaks=c(0.1,0.2,0.3,0.4,0.5), labels=c("10%","20%","30%","40%","50%"))
  plot <- plot + xlab("Queries per session") + ylab("% of total sessions")
  ggsave(paste(graphicsPath,"QueriesPerSession.pdf", sep = "/"))
}

main <- function(){
  readFromStdin()
  filename <- "/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/OutputFiles/SessionLength.txt"
  printToFile(filename)
  dataFrame <<- data.frame(1:10,queriesPerSession/numberSessions)
  drawGraphics()
  
}

main();