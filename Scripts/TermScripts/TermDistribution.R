source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

dataFrame <- data.frame(x= numeric(0), y= integer(0))

percentAllQueries <- vector()
percentUniqueQueries <- vector()
termType <- vector()

allQueriesWFuncWords <- 0
uniqueQueriesWFuncWords <- 0
allQueriesWoutFuncWords <- 0
uniqueQueriesWoutFuncWords <- 0

allQueriesWFuncWordsCounter <- 0
uniqueQueriesWFuncWordsCounter <- 0
allQueriesWoutFuncWordsCounter <- 0
uniqueQueriesWoutFuncWordsCounter <- 0

i<-0

parseString <- function(str){
  if(i==0){
    aLine <- strsplit(str, separator)
    allQueriesWFuncWords <<- as.integer(aLine[[1]][1])
    uniqueQueriesWFuncWords <<- as.integer(aLine[[1]][2])
    allQueriesWoutFuncWords <<- as.integer(aLine[[1]][3])
    uniqueQueriesWoutFuncWords <<- as.integer(aLine[[1]][4])
    i <<- 1
  } else if(i == 1) {
    if(str == "without"){
      i <<- 2
    }
    else {
      aLine <- strsplit(str, separator)
      uniqueQueriesWFuncWordsCounter <<- uniqueQueriesWFuncWordsCounter+1
      allQueriesWFuncWordsCounter <<- allQueriesWFuncWordsCounter + as.integer(aLine[[1]][2])
      
      percentUniqueQueries <<- append(percentUniqueQueries, as.numeric(rawPercent(uniqueQueriesWFuncWordsCounter/uniqueQueriesWFuncWords)))
      percentAllQueries <<- append(percentAllQueries, as.numeric(rawPercent(allQueriesWFuncWordsCounter/allQueriesWFuncWords)))
      termType <<- append(termType, "w/ function words")
    }

  } else {
    aLine <- strsplit(str, separator)
    uniqueQueriesWoutFuncWordsCounter <<- uniqueQueriesWoutFuncWordsCounter+1
    allQueriesWoutFuncWordsCounter <<- allQueriesWoutFuncWordsCounter + as.integer(aLine[[1]][2])
    
    percentUniqueQueries <<- append(percentUniqueQueries, as.numeric(rawPercent(uniqueQueriesWoutFuncWordsCounter/uniqueQueriesWoutFuncWords)))
    percentAllQueries <<- append(percentAllQueries, as.numeric(rawPercent(allQueriesWoutFuncWordsCounter/allQueriesWoutFuncWords)))
    termType <<- append(termType, "w/out function words")
  }
}

printToFile <- function(filename){
  write("TERM DISTRIBUTION", file=filename, append=FALSE)
  for(i in 1:length(percentAllQueries)){
    write(paste(percentAllQueries[i], percentUniqueQueries[i], sep=" -> "), file=filename, append=TRUE)
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]],colour=dataFrame[[3]]))
  plot <- plot + geom_line(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + scale_y_continuous(breaks=c(0.00,20.00,40.00,60.00,80.00,100.00), labels=c("0%", "20%","40%","60%","80%","100%"))
  plot <- plot + xlab("% of unique terms") + ylab("% of all terms")
  plot <- plot + labs(colour="Terms groups") + theme(legend.position="top")
  
  ggsave(paste(graphicsPath,"TermDistribution.pdf", sep = "/"))
}

main <- function(){
  readFromStdin()
  #create data frame
  dataFrame <<- data.frame(percentUniqueQueries, percentAllQueries)
  filename <- paste(outputPath,"TermDistribution.txt", sep = "/")
  printToFile(filename)
  dataFrame <<- data.frame(percentUniqueQueries, percentAllQueries, termType)
 # print(dataFrame)
  drawGraphics()
}

main();