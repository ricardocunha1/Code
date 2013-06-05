source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

queries <- vector()
queryCounter <- vector()

numberQueries <-0

i<-0
parseString <- function(str){
  if(i==0){
    numberQueries <<- as.integer(str)
    i<<-i+1
  } else {
    aLine <- strsplit(str,separator)
    queries <<- append(queries, aLine[[1]][1])
    queryCounter <<- append(queryCounter, as.integer(aLine[[1]][2]))
  }
}

printToFile <- function(filename){
  write("MOST SEARCHED QUERIES",file=filename, append=FALSE)
  for(i in 1:length(queries)){
    write(paste(queries[i],paste(queryCounter[i],percent(queryCounter[i]/numberQueries),sep=" -> "),sep=" -> "),
          file=filename, append=TRUE)
  }
}

main <- function(){
  print("Initiating MostSearchedQueries.R")
  readFromStdin()
  filename <- paste(outputPath,"MostSearchedQueries.txt", sep = "/")
  printToFile(filename)
}

main()