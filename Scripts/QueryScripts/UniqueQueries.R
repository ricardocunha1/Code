source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

uniqueQueries <- 0
totalQueries <- 0
ratio <- 0
top1000 <- 0

state <- 1
parseString <- function(str){
  aQuery = strsplit(str,separator)
  if(state == 1){
    uniqueQueries <<- aQuery[[1]][2]
    state <<- 2
  } else if(state == 2){
    totalQueries <<- aQuery[[1]][2]
    state <<- 3
  } else if(state == 3){
    ratio <<- aQuery[[1]][2]
    state <<- 4
  } else if(state == 4){
    top1000 <<- aQuery[[1]][2]
  }
}

printStats <- function(filename){
  write("UNIQUE QUERIES",file=filename,append=FALSE)
  write(paste("Number of unique queries: ",uniqueQueries,sep=" -> "),file=filename,append=TRUE)
  write(paste("Ratio: ",ratio,sep=" -> "),file=filename,append=TRUE)
  write(paste("Top 1000 unique queries account for(X) of total queries: ",top1000,sep=" -> "),file=filename,append=TRUE)
  
}

main <- function(){
  readFromStdin()
  filename <- paste(outputPath,"UniqueQueries.txt", sep = "/")
  printStats(filename)
}

main()