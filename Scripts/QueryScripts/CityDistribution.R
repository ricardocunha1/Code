source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

cities <- vector()
citiesValues <- vector()
nTotalQueries <- 0
counter <- 0

parseString <- function(str){
  #print the 10 cities with most queries
  if(counter == 0){
    nTotalQueries <<- as.integer(str)
    counter <<- counter+1
  } else {
  #  print(str)
    aCity <- strsplit(str, separator)
    cities <<- append(cities, aCity[[1]][1])
    citiesValues <<- append(citiesValues, as.integer(aCity[[1]][2]))
  }
  
  
}

printResults <- function(filename){
  i<-1
  write("QUERIES PER CITY", file=filename, append=FALSE)
  write(paste("Total number of queries(not empty)",nTotalQueries,sep=": "), file=filename, append=TRUE)
  while(i<=length(cities)){
    write(paste(cities[i],paste(citiesValues[i],percent(citiesValues[i]/nTotalQueries),sep=" -> "),sep=" -> "),
          file=filename,append=TRUE)
    i <- i+1
  }
  
}

main <- function(){
  readFromStdin()
  filename <- paste(outputPath,"CityDistribution.txt", sep = "/")
  printResults(filename)
}

main();