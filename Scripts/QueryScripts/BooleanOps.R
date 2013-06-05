source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

#boolean queries
nBoolean <- 0
nTotalQueries <- 0

booleanTypes <- c("MORE","NOT","AND","OR","SITE","FILE","PHRASE","FILL")
booleanTypesCounter <- vector()

#boolean sessions
nTotalSessions <- 0
nBooleanSessions <-0
i<-0

parseString <- function(str){
  if(i==0){
    aLine <- strsplit(str,separator)
    nBoolean <<- as.integer(aLine[[1]][1])
    nTotalQueries <<- as.integer(aLine[[1]][2])
    i <<- i+1
  } else if(i==1){
    aLine <- strsplit(str,separator)
    nBooleanSessions <<- as.integer(aLine[[1]][1])
    nTotalSessions <<- as.integer(aLine[[1]][2])
    i <<- i+1
  } else {
    booleanTypesCounter <<- append(booleanTypesCounter, as.integer(str))
  }
  
}

printToFile <- function(filename){
  write("BOOLEAN OPERATORS(QUERIES)", file=filename, append=FALSE)
  write(paste("Number of Boolean queries", paste(nBoolean,percent(nBoolean/nTotalQueries),sep=" -> "),sep=" -> "),
        file=filename, append=TRUE)
  
  write("BOOLEAN OPERATORS(SESSIONS)", file=filename, append=TRUE)
  write(paste("Number of Boolean sessions", paste(nBooleanSessions,percent(nBooleanSessions/nTotalSessions),sep=" -> "),sep=" -> "),
        file=filename, append=TRUE)
  
  write("BOOLEAN OPERATORS DIVIDED BY TYPE", file=filename, append=TRUE)
  for(i in 1:length(booleanTypes)){
    write(paste(booleanTypes[i],paste(booleanTypesCounter[i],percent(booleanTypesCounter[i]/nBoolean),sep=" -> "),sep=" -> "),
          file=filename, append=TRUE)
  }
  
  
}

main <- function(){
  print("Initiating BooleanOps.R")
  readFromStdin();
  filename <- paste(outputPath,"BooleanOps.txt", sep = "/")
  printToFile(filename)
}

main();