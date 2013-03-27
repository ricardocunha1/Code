source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

countries <- vector()
nQueries <- vector()
nTotalQueries <- 0


parseString <- function(str){
  #print(str)
  #test for key presence
  if(str != "EMPTY"){
    i <- 1
    while(i<=length(countries)){
      if(countries[i] == str){
        nQueries[i] <<- nQueries[i]+1
        nTotalQueries <<- nTotalQueries+1
        return()
      }
      i <- i+1
    }
    
    countries <<- append(countries, str)
    nQueries <<- append(nQueries, 1)
    nTotalQueries <<- nTotalQueries+1
  }
  
}

printResults <- function(filename){
  i<-1
  write("QUERIES PER COUNTRY", file=filename, append=FALSE)
  while(i<=length(countries)){
    write(paste(countries[i],nQueries[i],percent(nQueries[i]/nTotalQueries),sep=":"),
          file=filename,append=TRUE)
    i <- i+1
  }
  
}

main <- function(){
  readFromStdin()
  filename <- "/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/OutputFiles/CountryDistribution.txt"
  printResults(filename)
}

main();