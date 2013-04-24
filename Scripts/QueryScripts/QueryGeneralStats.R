source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/TermScripts/FunctionWords.R")

#vectores que guardam cada query e a sua frequencia
queries <- vector()
nQueries <- vector()

#vectores que guardam, em cada posição, o numero de termos da query actual
wordsPerQuery <- vector()
wordsPerQueryWoutFuncWords <- vector()

#vectores que guardam, em cada posição, o numero de caracteres da query actual
charsPerQuery <- vector()
charsPerQueryWoutFuncWords <- vector()

#vectores que fazem a soma das queries com i termos na posição i
wordsCounter <- rep(0,10)
wordsCounterWoutFuncWords <- rep(0,10)

#numero total de queries
iTotalQueries <- 0
iTotalQueriesWoutFuncWords <- 0

#numero de queries que sao URLs
urlQueries <- 0

#numero de unique queries
uniqueQueries <- 0

#vectores que guardam o numero de termos/caracteres da query actual. Destinados apenas a UNIQUE queries
wordsPerUniqueQuery <- vector()
charsPerUniqueQuery <- vector()

dataFrame <- data.frame(x= numeric(0), y= integer(0))

charsWoutFuncWords <- function(words){
  sNewQuery <- ""
  for(i in 1:length(words)){
    if(!isFunctionWord(words[i])){
      if(sNewQuery != ""){
        sNewQuery <- paste(sNewQuery,words[i],sep=" ")
      } else {
        sNewQuery = words[i]
      }
    }
  }
  
  return(nchar(sNewQuery))
}

termsWoutFuncWords <- function(words){
  newVector <- vector()
  for(i in 1:length(words)){
    if(!isFunctionWord(words[i])){
      newVector <- append(newVector, words[i])
    }
  }
  
  return(length(newVector))
}

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  if(aQuery[[1]][1] == "URLs"){
    urlQueries <<- as.integer(aQuery[[1]][2])
  } else
  {
    sQuery <- aQuery[[1]][1]
    uniqueQueries <<- uniqueQueries + 1
    #words
    words <- strsplit(sQuery, " ")
    iWordsPerQuery <- length(words[[1]])
    iWordsPerQueryWoutFuncWords <- termsWoutFuncWords(words[[1]])
  
    if(iWordsPerQuery >= 10){
      wordsCounter[10] <<- wordsCounter[10]+as.integer(aQuery[[1]][2]);
    } else {
      wordsCounter[iWordsPerQuery] <<- wordsCounter[iWordsPerQuery] + as.integer(aQuery[[1]][2])
    }
    
    if(iWordsPerQueryWoutFuncWords >= 10){
      wordsCounterWoutFuncWords[10] <<- wordsCounterWoutFuncWords[10]+as.integer(aQuery[[1]][2])
    } else {
      wordsCounterWoutFuncWords[iWordsPerQueryWoutFuncWords] <<- wordsCounterWoutFuncWords[iWordsPerQueryWoutFuncWords]+as.integer(aQuery[[1]][2])
    }
    
    queries <<- append(queries, sQuery)
    nQueries <<- append(nQueries, as.integer(aQuery[[1]][2]))
    
    
    for(i in 1:as.integer(aQuery[[1]][2])){
      #words
      wordsPerQuery <<- append(wordsPerQuery, iWordsPerQuery)
      wordsPerQueryWoutFuncWords <<- append(wordsPerQueryWoutFuncWords, iWordsPerQueryWoutFuncWords)
      #characters
      charsPerQuery <<- append(charsPerQuery, nchar(sQuery))
      charsPerQueryWoutFuncWords <<- append(charsPerQueryWoutFuncWords, charsWoutFuncWords(words[[1]]))
    }
    
    #mean/median stats for UNIQUE queries only
    wordsPerUniqueQuery <<- append(wordsPerUniqueQuery, iWordsPerQuery)
    charsPerUniqueQuery <<- append(charsPerUniqueQuery, nchar(sQuery))
    
    
  
  }
}

printTermsPerQuery <- function(filename){
  write("WORDS PER QUERY WITH FUNCTION WORDS", file=filename, append=FALSE)
  write(paste("Mean words per query:",mean(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Median words per query:",median(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev words per query:",sd(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  write("WORDS PER QUERY WITHOUT FUNCTION WORDS", file=filename, append=TRUE)
  write(paste("Mean words per query:",mean(wordsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
  write(paste("Median words per query:",median(wordsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev words per query:",sd(wordsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
  
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
  write(paste("Mean words per query:",mean(wordsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Median words per query:",median(wordsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev words per query:",sd(wordsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
}

printCharsPerQuery <- function(filename){
  write("",file=filename, append=TRUE)
  write("CHARS PER QUERY WITH FUNCTION WORDS", file=filename, append=TRUE)
  write(paste("Mean chars per query:",mean(charsPerQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Median chars per query:",median(charsPerQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev chars per query:",sd(charsPerQuery), sep=" "), file=filename, append=TRUE)
  
  write("CHARS PER QUERY WITHOUT FUNCTION WORDS", file=filename, append=TRUE)
  write(paste("Mean chars per query:",mean(charsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
  write(paste("Median chars per query:",median(charsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev chars per query:",sd(charsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
}

printCharsPerUniqueQuery <- function(filename){
  write("CHARS PER UNIQUE QUERY", file=filename, append=TRUE)
  write(paste("Mean chars per query:",mean(charsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Median chars per query:",median(charsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
  write(paste("Std Dev chars per query:",sd(charsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
}

printMostSearched <- function(filename){
  write("TOP50 MOST SEARCHED QUERIES", file=filename, append=TRUE)
  for(i in 1:50){
    write(paste(queries[i], paste(nQueries[i],percent(nQueries[i]/iTotalQueries),sep=" -> "),sep=" -> "),file=filename,append=TRUE)
  }
}

printUniqueQueries <- function(filename){
  write("TOP1000 UNIQUE QUERIES ARE:", file=filename,append=TRUE)
  top1000unique <- 0
  for(i in 1:1000){
    top1000unique <- top1000unique + nQueries[i]
  }
  
  write(paste(percent(top1000unique/iTotalQueries),"of total queries correspond to the top1000 unique queries",sep=" "),file=filename,append=TRUE)
}

printStats <- function(){
  filename <- paste(outputPath,"QueryGeneralStats.txt", sep = "/")
  printTermsPerQuery(filename)
  printTermsPerUniqueQuery(filename)
  printCharsPerQuery(filename)
  printCharsPerUniqueQuery(filename)
  printMostSearched(filename)
  printUniqueQueries(filename)
  write("URL QUERIES STATS", file=filename, append=TRUE)
  write(paste(urlQueries, percent(urlQueries/iTotalQueries), sep=" -> "),file=filename, append=TRUE)
  write("UNIQUE QUERIES", file=filename, append=TRUE)
  write(paste(uniqueQueries,percent(uniqueQueries/iTotalQueries),sep=" -> "),file=filename,append=TRUE)
}

drawGraphics <- function(filename){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]]))
  plot <- plot + geom_bar(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(1:10), labels=c("1","2","3","4","5","6","7","8","9","10+"))
  plot <- plot + scale_y_continuous(breaks=c(0.1,0.2,0.3,0.4,0.5), labels=c("10%","20%","30%","40%","50%"))
  plot <- plot + xlab("Terms per query") + ylab("% of total queries")
  ggsave(paste(graphicsPath,filename, sep = "/"))
}

main <- function(){
  readFromStdin();
  printStats();
  
  #graphic of terms per query - w/function words
  dataFrame <<- data.frame(1:10, wordsCounter/iTotalQueries)
  filename <- "TermsPerQueryWFunctionWords.pdf"
  drawGraphics(filename)
  
  #graphic of terms per query - w/out function words
  dataFrame <<- data.frame(1:10, wordsCounterWoutFuncWords/iTotalQueriesWoutFuncWords)
  filename <- "TermsPerQueryWoutFunctionWords.pdf"
  drawGraphics(filename)
  
  
}

main();