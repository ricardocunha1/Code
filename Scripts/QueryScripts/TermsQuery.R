source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/TermScripts/FunctionWords.R")
dataFrame <- data.frame(x= numeric(0), y= integer(0))

#vectores que guardam, em cada posição, o numero de termos da query actual
#wordsPerQuery <- vector()
wordsPerQuery <- 0
nWordsPerQuery <- 0

#wordsPerQueryWoutFuncWords <- vector()
wordsPerQueryWoutFuncWords <- 0
nWordsPerQueryWoutFuncWords <- 0

#vectores que fazem a soma das queries com i termos na posição i
wordsCounter <- rep(0,10)
wordsCounterWoutFuncWords <- rep(0,10)

#numero de unique queries
uniqueQueries <- 0

#vectores que guardam o numero de termos/caracteres da query actual. Destinados apenas a UNIQUE queries
#wordsPerUniqueQuery <- vector()
wordsPerUniqueQuery <- 0
nWordsPerUniqueQuery <- 0

iTotalQueries <- 0
iTotalQueriesWoutFuncWords <- 0

termsWoutFuncWords <- function(words){
  newVector <- vector()
  for(i in 1:length(words)){
    if(!isFunctionWord(words[i])){
      newVector <- append(newVector, words[i])
    }
  }
  
  return(length(newVector))
}


counter <- 0
parseString <- function(str){
  aQuery <- strsplit(str, separator)
  print(counter)
  counter <<- counter +1
  if(aQuery[[1]][1] != "TYPEDURLs"){
    uniqueQueries <<- uniqueQueries + 1
    
    sQuery <- aQuery[[1]][1]
    words <- strsplit(sQuery, " ")
    iWordsPerQuery <- length(words[[1]])
    iWordsPerQueryWoutFuncWords <- termsWoutFuncWords(words[[1]])
    
    if(iWordsPerQuery >= 10){
      wordsCounter[10] <<- wordsCounter[10]+as.integer(aQuery[[1]][2])
    } else {
      wordsCounter[iWordsPerQuery] <<- wordsCounter[iWordsPerQuery] + as.integer(aQuery[[1]][2])
    }
    
    if(iWordsPerQueryWoutFuncWords >= 10){
      wordsCounterWoutFuncWords[10] <<- wordsCounterWoutFuncWords[10]+as.integer(aQuery[[1]][2])
    } else {
      wordsCounterWoutFuncWords[iWordsPerQueryWoutFuncWords] <<- wordsCounterWoutFuncWords[iWordsPerQueryWoutFuncWords]+as.integer(aQuery[[1]][2])
    }
    
    for(i in 1:as.integer(aQuery[[1]][2])){
      wordsPerQuery <<- wordsPerQuery + as.integer(iWordsPerQuery)
      nWordsPerQuery <<- nWordsPerQuery + 1
      
      # wordsPerQueryWoutFuncWords <<- append(wordsPerQueryWoutFuncWords, iWordsPerQueryWoutFuncWords)
      wordsPerQueryWoutFuncWords <<- wordsPerQueryWoutFuncWords + as.integer(iWordsPerQueryWoutFuncWords)
      nWordsPerQueryWoutFuncWords <<- nWordsPerQueryWoutFuncWords + 1
    }
    
    #mean/median stats for UNIQUE queries only
    #wordsPerUniqueQuery <<- append(wordsPerUniqueQuery, iWordsPerQuery)
    wordsPerUniqueQuery <<- wordsPerUniqueQuery + as.integer(iWordsPerQuery)
    nWordsPerUniqueQuery <<- nWordsPerUniqueQuery + 1

  }
}
  
printTermsPerQuery <- function(filename){
    write("WORDS PER QUERY WITH FUNCTION WORDS", file=filename, append=FALSE)
    write(paste("Mean words per query:",wordsPerQuery/nWordsPerQuery, sep=" "), file=filename, append=TRUE)
    # write(paste("Median words per query:",median(wordsPerQuery), sep=" "), file=filename, append=TRUE)
    # write(paste("Std Dev words per query:",sd(wordsPerQuery), sep=" "), file=filename, append=TRUE)
    write("WORDS PER QUERY WITHOUT FUNCTION WORDS", file=filename, append=TRUE)
    write(paste("Mean words per query:",wordsPerQueryWoutFuncWords/nWordsPerQueryWoutFuncWords, sep=" "), file=filename, append=TRUE)
    # write(paste("Median words per query:",median(wordsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
    # write(paste("Std Dev words per query:",sd(wordsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
    
    #print percentages for 1,2,3,4,5 terms etc.
    i<-1
    write("",file=filename, append=TRUE)
    write("Number of queries for each number of terms (WITH FUNCTION WORDS)", file=filename, append=TRUE)
    while(i<=10){
      termStr <- paste("Term", i, sep=" ")
      write(paste(termStr,wordsCounter[i],sep=":"), file=filename, append=TRUE)
      iTotalQueries <<- iTotalQueries + wordsCounter[i]
      i <- i+1
    }
    
    write("Number of queries for each number of terms (WITHOUT FUNCTION WORDS)", file=filename, append=TRUE)
    i<-1
    while(i<=10){
      termStr <- paste("Term", i, sep=" ")
      write(paste(termStr,wordsCounterWoutFuncWords[i],sep=":"), file=filename, append=TRUE)
      iTotalQueriesWoutFuncWords <<- iTotalQueriesWoutFuncWords + wordsCounterWoutFuncWords[i]
      i <- i+1
    }
    write(paste("Total number of queries", iTotalQueries, sep=":"), file=filename, append=TRUE)
    write("",file=filename, append=TRUE)
    write(paste("In Percentages", iTotalQueries, sep=":"), file=filename, append=TRUE)
    
    write("WITH FUNCTION WORDS", file=filename, append=TRUE)
    i<-1
    while(i<=10){
      termStr <- paste("Term", i, sep=" ")
      write(paste(termStr,percent(wordsCounter[i]/iTotalQueries),sep=":"), file=filename, append=TRUE)
      i<-i+1
    }
    
    write("WITHOUT FUNCTION WORDS", file=filename, append=TRUE)
    i<-1
    while(i<=10){
      termStr <- paste("Term", i, sep=" ")
      write(paste(termStr,percent(wordsCounterWoutFuncWords[i]/iTotalQueriesWoutFuncWords),sep=":"), file=filename, append=TRUE)
      i<-i+1
    }
  
}

printTermsPerUniqueQuery <- function(filename){
  write("WORDS PER UNIQUE QUERY", file=filename, append=TRUE)
  write(paste("Mean words per query:",wordsPerUniqueQuery/nWordsPerUniqueQuery, sep=" "), file=filename, append=TRUE)
  #  write(paste("Median words per query:",median(wordsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
  #  write(paste("Std Dev words per query:",sd(wordsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
}

printStats <- function(){
  filename <- paste(outputPath,"TermsQuery.txt", sep = "/")
  printTermsPerQuery(filename)
  printTermsPerUniqueQuery(filename)
}

drawGraphics <- function(filename){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], fill=dataFrame[[3]]))
  plot <- plot + geom_bar(stat="identity", position=position_dodge())
  plot <- plot + scale_x_continuous(breaks=c(1:10), labels=c("1","2","3","4","5","6","7","8","9","10+"))
  plot <- plot + scale_y_continuous(breaks=c(0.1,0.2,0.3,0.4,0.5), labels=c("10%","20%","30%","40%","50%"))
  plot <- plot + xlab("Terms per query") + ylab("% of total queries")
  plot <- plot + labs(fill="Categories") + theme(legend.position="top")
  ggsave(paste(graphicsPath,filename, sep = "/"))
}

main <- function(){
  readFromStdin()
  printStats()
  
  indexes <- c(1:10,1:10)
  words <- c(wordsCounter/iTotalQueries, wordsCounterWoutFuncWords/iTotalQueriesWoutFuncWords)
  funcwords <- c(rep("w/function words",10), rep("w/out function words",10))
  
  #graphic of terms per query - w/function words
  dataFrame <<- data.frame(indexes, words,funcwords)
  filename <- "TermsPerQuery.jpg"
  drawGraphics(filename)
  
  #graphic of terms per query - w/out function words
#  dataFrame <<- data.frame(1:10, wordsCounterWoutFuncWords/iTotalQueriesWoutFuncWords)
  #filename <- "TermsPerQueryWoutFunctionWords.jpg"
  #drawGraphics(filename)
  
  
}

main();