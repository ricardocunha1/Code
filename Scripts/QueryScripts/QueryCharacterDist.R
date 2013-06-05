source("/Users/ricardocunha/Documents/FEUP/5ano/MSc\ Thesis/Thesis/Code/Scripts/Utils/mainBody.R")

#vectores para queries c/ function words
charLength <- vector()
charLengthCounter <- vector()
queryCounter <- 0

dataFrame <- data.frame(x= numeric(0), y= integer(0))

parseString <- function(str){
  aLine <- strsplit(str,separator)
  charLength <<- append(charLength,as.integer(aLine[[1]][1]))
  charLengthCounter <<- append(charLengthCounter,as.integer(aLine[[1]][2]))
  queryCounter <<- queryCounter + as.integer(aLine[[1]][2])
}

printToFile <- function(filename){
  write("CHARACTERS PER QUERY DISTRIBUTION", file=filename, append=FALSE)
  for(i in 1:length(charLength)){
    write(paste(charLength[i],paste(charLengthCounter[i],rawPercent(charLengthCounter[i]/queryCounter),sep=" -> "),sep=" -> "), file=filename, append=TRUE)
  }
}

drawGraphics <- function(){
  plot <- ggplot(data=dataFrame, aes(x=dataFrame[[1]], y=dataFrame[[2]]))
  plot <- plot + geom_bar(stat="identity")
  plot <- plot + scale_x_continuous(breaks=c(0,10,20,30,40,50,60,70,80,90,100), limits=c(0,100))
  plot <- plot + scale_y_continuous(breaks=c(0.05,0.1,0.15,0.2), labels=c("5%","10%","15%","20%"))
  plot <- plot + xlab("Characters per query") + ylab("% of total queries")
  plot <- plot + scale_fill_discrete(name="Terms groups") + theme(legend.position="top")
  ggsave(paste(graphicsPath,"QueryCharacterDist.jpg", sep = "/"))
}

main <- function(){
  print("Initiating QueryCharacterDist.R")
  readFromStdin()
  filename <- paste(outputPath,"QueryCharacterDist.txt", sep = "/")
  printToFile(filename)
  # print(dataFrame)
  dataFrame <<- data.frame(charLength, charLengthCounter/queryCounter)
  drawGraphics()
}

main()