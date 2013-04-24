source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

dataFrame <- data.frame(x= numeric(0), y= integer(0))

percentAllQueries <- vector()
percentUniqueQueries <- vector()

allQueriesCounter <- 0
uniqueQueriesCounter <- 0

nTotalQueries <- 0
nUniqueQueries <- 0

i<-0

parseString <- function(str){
  if(i==0){
    aLine <- strsplit(str,separator)
    nTotalQueries <<- as.integer(aLine[[1]][1])
    nUniqueQueries <<- as.integer(aLine[[1]][2])
    i <<- 1
  } else {
    #process unique queries vector
    uniqueQueriesCounter <<- uniqueQueriesCounter+1
   # print(typeof(as.numeric(rawPercent(uniqueQueriesCounter/nUniqueQueries))))
    percentUniqueQueries <<- append(percentUniqueQueries, as.numeric(rawPercent(uniqueQueriesCounter/nUniqueQueries)))
    
    #process all queries vector
    aLine <- strsplit(str, separator)
    allQueriesCounter <<- allQueriesCounter + as.integer(aLine[[1]][2])
    percentAllQueries <<- append(percentAllQueries, as.numeric(rawPercent(allQueriesCounter/nTotalQueries)))
  }
}

printToFile <- function(filename){
  write("QUERY DISTRIBUTION", file=filename, append=FALSE)
  for(i in 1:length(percentAllQueries)){
    write(paste(percentAllQueries[i], percentUniqueQueries[i], sep=" -> "), file=filename, append=TRUE)
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], group=1))
  plot <- plot + geom_line(colour="red")
  plot <- plot + scale_x_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + scale_y_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + xlab("% of unique queries") + ylab("% of all queries")
  ggsave(paste(graphicsPath,"QueryDistribution.pdf", sep = "/"))
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(percentUniqueQueries, percentAllQueries)
  filename <- paste(outputPath,"QueryDistribution.txt", sep = "/")
  dataFrame <<- data.frame(percentUniqueQueries, percentAllQueries)
  printToFile(filename)
 # print(dataFrame)
  drawGraphics()
}

main();