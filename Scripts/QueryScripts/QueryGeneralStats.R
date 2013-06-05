source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/TermScripts/FunctionWords.R")

#vectores que guardam, em cada posição, o numero de caracteres da query actual
#charsPerQuery <- vector()
charsPerQuery <- 0
nCharsPerQuery <- 0

#charsPerQueryWoutFuncWords <- vector()
charsPerQueryWoutFuncWords <- 0
nCharsPerQueryWoutFuncWords <- 0


#numero total de queries
iTotalQueries <- 0
iTotalQueriesWoutFuncWords <- 0

#numero de queries que sao URLs
urlQueries <- 0

#charsPerUniqueQuery <- vector()
charsPerUniqueQuery <- 0
nCharsPerUniqueQuery <- 0

uniqueQueries <- 0

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


parseString <- function(str){
  aQuery <- strsplit(str, separator)
  if(aQuery[[1]][1] == "TYPEDURLs"){
    urlQueries <<- as.integer(aQuery[[1]][2])
  } else
  {
    uniqueQueries <<- uniqueQueries + 1
    sQuery <- aQuery[[1]][1]
  #  print(uniqueQueries)
    #words
    words <- strsplit(sQuery, " ")
    charsPerUniqueQuery <<- charsPerUniqueQuery + as.integer(nchar(sQuery))
    for(i in 1:as.integer(aQuery[[1]][2])){      
      #characters
      
      #charsPerQuery <<- append(charsPerQuery, nchar(sQuery))
      charsPerQuery <<- charsPerQuery + as.integer(nchar(sQuery))
      nCharsPerQuery <<- nCharsPerQuery + 1
      
      #charsPerQueryWoutFuncWords <<- append(charsPerQueryWoutFuncWords, charsWoutFuncWords(words[[1]]))
      charsPerQueryWoutFuncWords <<- charsPerQueryWoutFuncWords + as.integer(charsWoutFuncWords(words[[1]]))
      nCharsPerQueryWoutFuncWords <<- nCharsPerQueryWoutFuncWords + 1
    }    
  
  }
}

printCharsPerQuery <- function(filename){
  write("",file=filename, append=FALSE)
  write("CHARS PER QUERY WITH FUNCTION WORDS", file=filename, append=TRUE)
  write(paste("Mean chars per query:",charsPerQuery/nCharsPerQuery, sep=" "), file=filename, append=TRUE)
#  write(paste("Median chars per query:",median(charsPerQuery), sep=" "), file=filename, append=TRUE)
 # write(paste("Std Dev chars per query:",sd(charsPerQuery), sep=" "), file=filename, append=TRUE)
  
  write("CHARS PER QUERY WITHOUT FUNCTION WORDS", file=filename, append=TRUE)
  write(paste("Mean chars per query:",charsPerQueryWoutFuncWords/nCharsPerQueryWoutFuncWords, sep=" "), file=filename, append=TRUE)
 # write(paste("Median chars per query:",median(charsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
 # write(paste("Std Dev chars per query:",sd(charsPerQueryWoutFuncWords), sep=" "), file=filename, append=TRUE)
}

printCharsPerUniqueQuery <- function(filename){
  write("CHARS PER UNIQUE QUERY", file=filename, append=TRUE)
  write(paste("Mean chars per query:",charsPerUniqueQuery/uniqueQueries, sep=" "), file=filename, append=TRUE)
#  write(paste("Median chars per query:",median(charsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
#  write(paste("Std Dev chars per query:",sd(charsPerUniqueQuery), sep=" "), file=filename, append=TRUE)
}

printStats <- function(){
  filename <- paste(outputPath,"QueryGeneralStats.txt", sep = "/")
  printCharsPerQuery(filename)
  printCharsPerUniqueQuery(filename)
  write("URL QUERIES STATS", file=filename, append=TRUE)
  write(paste(urlQueries, percent(urlQueries/nCharsPerQuery), sep=" -> "),file=filename, append=TRUE)
}


main <- function(){
  readFromStdin()
  printStats() 
  
}

main();