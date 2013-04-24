source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

charLength <- vector()
charLengthCounter <- vector()
termType <- vector()

state <- 0

dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  if(str == "without"){
    state <<- 1
  } else {
    aLine <- strsplit(str,separator)
    charLength <<- append(charLength,as.integer(aLine[[1]][1]))
    charLengthCounter <<- append(charLengthCounter,as.integer(aLine[[1]][2]))
    if(state == 0){
      termType <<- append(termType, "w/ function words")
    } else {
      termType <<- append(termType, "w/out function words")
    }
  }
  
}

printToFile <- function(filename){
  write("CHARACTERS PER TERM DISTRIBUTION", file=filename, append=FALSE)
  for(i in 1:length(charLength)){
    write(paste(charLength[i],charLengthCounter[i],sep=" -> "), file=filename, append=TRUE)
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]], fill=dataFrame[[3]]))
  plot <- plot + geom_bar(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(0,10,20,30,40,50,60))
  plot <- plot + xlab("Characters per term") + ylab("Number of terms")
  plot <- plot + scale_fill_discrete(name="Terms groups") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"TermCharacterDist.pdf", sep = "/"))
}

main <- function(){
  readFromStdin();
  filename <- paste(outputPath,"TermCharacterDist.txt",sep="/")
  printToFile(filename)
  dataFrame <<- data.frame(charLength, charLengthCounter, termType)
  print(dataFrame)
  drawGraphics()
}

main();