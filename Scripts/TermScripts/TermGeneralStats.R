source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")
source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/TermScripts/FunctionWords.R")

terms <- vector()
termsCounter <- vector()

nCharsPerTerm <- vector()
nCharsPerTermWoutFuncWds <- vector()

nTerms <- 0
nTermsWoutFuncWds <- 0
nTermsNeverRepeated <-0

df <- data.frame(a=numeric(), b=numeric(), c=character())

parseString <- function(str){
  aLine <- strsplit(str, separator)
  sTerm <- aLine[[1]][1]
  #print(str)
  iCounter <- as.integer(aLine[[1]][2])
  if(sTerm != ""){
    if(!is.na(iCounter)){ #if iCounter is defined
      nTerms <<- nTerms + iCounter
      if(!isFunctionWord(sTerm)){ #is not a function word
        nTermsWoutFuncWds <<- nTermsWoutFuncWds + iCounter
        nCharsPerTermWoutFuncWds <<- append(nCharsPerTermWoutFuncWds, nchar(sTerm))
      }
      
      if(iCounter == 1){
        nTermsNeverRepeated <<- nTermsNeverRepeated + 1
      }
      terms <<- append(terms, sTerm)
      termsCounter <<- append(termsCounter, iCounter)
      nCharsPerTerm <<- append(nCharsPerTerm, nchar(sTerm))
    }
  
  }
  
}

printToFile <- function(filename){
  write("TERM GENERAL STATS", file=filename, append=FALSE)
  write(paste("Number of terms w/ function words", nTerms,sep=" -> "), file=filename, append=TRUE)
  write(paste("Number of terms w/out function words", nTermsWoutFuncWds,sep=" -> "), file=filename, append=TRUE)
  write(paste("Number of UNIQUE terms", paste(length(terms),percent(length(terms)/nTerms),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  write(paste("Number of NEVER-REPEATED from UNIQUE terms", paste(nTermsNeverRepeated,percent(nTermsNeverRepeated/length(terms)),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  write(paste("Number of NEVER-REPEATED from ALL terms", paste(nTermsNeverRepeated,percent(nTermsNeverRepeated/nTerms),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  
  write(paste("Mean of characters per term w/ function words", mean(nCharsPerTerm),sep=" -> "), file=filename, append=TRUE)
  write(paste("Meadian of characters per term w/ function words", median(nCharsPerTerm),sep=" -> "), file=filename, append=TRUE)
  write(paste("StdDev of characters per term w/ function words", sd(nCharsPerTerm),sep=" -> "), file=filename, append=TRUE)
  write(paste("Mean of characters per term w/out function words", mean(nCharsPerTermWoutFuncWds),sep=" -> "), file=filename, append=TRUE)
  write(paste("Meadian of characters per term w/out function words", median(nCharsPerTermWoutFuncWds),sep=" -> "), file=filename, append=TRUE)
  write(paste("StdDev of characters per term w/out function words", sd(nCharsPerTermWoutFuncWds),sep=" -> "), file=filename, append=TRUE)

  write("TOP 50 TERMS", file=filename, append=TRUE)
  i<-1
  while(i <= 50){
    write(paste(terms[i], paste(termsCounter[i],percent(termsCounter[i]/nTerms),sep=" -> "), sep=" -> "),file=filename, append=TRUE)
    i<-i+1
  }
  
}

drawGraphics <- function(){
  
}

main <- function(){
  print("Initiating TermGeneralStats.R")
  readFromStdin();
  filename <- paste(outputPath,"TermGeneralStats.txt",sep="/")
  printToFile(filename)
}

main();