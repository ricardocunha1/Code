source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

wordsPerQuery <- vector()
charsPerQuery <- vector()
wordsCounter <- rep(0,10)

parseString <- function(str){
  aQuery <- strsplit(str, ">>>")
  sQuery <- aQuery[[1]][1]
  
  #words
  words <- strsplit(sQuery, " ")
  iWordsPerQuery <- length(words[[1]])
  if(iWordsPerQuery >= 10){
    wordsCounter[10] <<- wordsCounter[10]+1;
  } else {
    wordsCounter[iWordsPerQuery] <<- wordsCounter[iWordsPerQuery] + 1
  }
  #print(iWordsPerQuery)
  wordsPerQuery <<- append(wordsPerQuery, iWordsPerQuery)
  
  #characters
  iCharsPerQuery <- nchar(sQuery)
  charsPerQuery <<- append(charsPerQuery, iCharsPerQuery)
  
}

printTermsPerQuery <- function(filename){
  write("WORDS PER QUERY", file=filename, append=FALSE)
  print("WORDS PER QUERY")
  write(paste("Mean words per query:",mean(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Mean words per query:",mean(wordsPerQuery), sep=" "))
  write(paste("Median words per query:",median(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Median words per query:",median(wordsPerQuery), sep=" "))
  write(paste("Std Dev words per query:",sd(wordsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Std Dev words per query:",sd(wordsPerQuery), sep=" "))
  
  #print percentages for 1,2,3,4,5 terms etc.
  iTotalQueries <- 0
  i<-1
  write("",file=filename, append=TRUE)
  write("Number of queries for each number of terms", file=filename, append=TRUE)
  while(i<=10){
    termStr <- paste("Term", i, sep=" ")
    write(paste(termStr,wordsCounter[i],sep=":"), file=filename, append=TRUE)
    iTotalQueries <- iTotalQueries + wordsCounter[i]
    i <- i+1
  }
  write(paste("Total number of queries", iTotalQueries, sep=":"), file=filename, append=TRUE)
  write("",file=filename, append=TRUE)
  write(paste("In Percentages", iTotalQueries, sep=":"), file=filename, append=TRUE)
  
  i<-1
  while(i<=10){
    termStr <- paste("Term", i, sep=" ")
    write(paste(termStr,percent(wordsCounter[i]/iTotalQueries),sep=":"), file=filename, append=TRUE)
    i<-i+1
  }
  
  
  
}

printCharsPerQuery <- function(filename){
  write("",file=filename, append=TRUE)
  write("CHARS PER QUERY", file=filename, append=TRUE)
  print("CHARS PER QUERY")
  write(paste("Mean chars per query:",mean(charsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Mean chars per query:",mean(charsPerQuery), sep=" "))
  write(paste("Median chars per query:",median(charsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Median chars per query:",median(charsPerQuery), sep=" "))
  write(paste("Std Dev chars per query:",sd(charsPerQuery), sep=" "), file=filename, append=TRUE)
  print(paste("Std Dev chars per query:",sd(charsPerQuery), sep=" "))
}

printStats <- function(){
  filename <- "/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/OutputFiles/QueryGeneralStats.txt"
  printTermsPerQuery(filename)
  printCharsPerQuery(filename)  
}

main <- function(){
  readFromStdin();
  printStats();
}

main();